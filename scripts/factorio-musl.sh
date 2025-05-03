#!/usr/bin/env bash
set -e

# 2. Clone gcompat and enter
git clone https://github.com/zsoltiv/gcompat.git
cd gcompat

# 3. Patch src/resolv.c: add __dn_expand right after __res_search
ed -s src/resolv.c << 'EOF'
/int __res_search/a
int __dn_expand(const unsigned char *msg, const unsigned char *eomorig,
                const unsigned char *comp_dn, char *exp_dn, int length)
{
    return dn_expand(msg, eomorig, comp_dn, exp_dn, length);
}
.
w
EOF

# 4. Patch src/resolv.c: append __res_nquery and alias at EOF
ed -s src/resolv.c << 'EOF'
$a
int __res_nquery(res_state statep, const char *dname, int class, int type,
               unsigned char *answer, int anslen)
{
    int rc;
    res_state tmp = malloc(sizeof(*statep));
    if (!statep || statep == &_res) {
        free(tmp);
        return -1;
    }
    memcpy(tmp, &_res, sizeof(_res));
    memcpy(&_res, statep, sizeof(*statep));
    rc = res_query(dname, class, type, answer, anslen);
    memcpy(statep, &_res, sizeof(*statep));
    memcpy(&_res, tmp, sizeof(*tmp));
    free(tmp);
    return rc;
}
weak_alias(__res_nquery, res_nquery);
.
w
EOF

# 5. Patch src/pthread.c: add pthread_cond_clockwait after mutexattr_setkind_np
ed -s src/pthread.c << 'EOF'
/int pthread_mutexattr_setkind_np/a
int pthread_cond_clockwait(pthread_cond_t *restrict cond,
                           pthread_mutex_t *restrict mutex,
                           clockid_t clock_id,
                           const struct timespec *restrict abstime)
{
    return pthread_cond_timedwait(cond, mutex, abstime);
}
.
w
EOF

# 6. Build & install
make LINKER_PATH=/lib/ld-musl-x86_64.so.1 LOADER_NAME=ld-linux-x86-64.so.2
sudo make LINKER_PATH=/lib/ld-musl-x86_64.so.1 LOADER_NAME=ld-linux-x86-64.so.2 install

# 7. Ensure loader symlink is in place
sudo ln -sf /lib/ld-linux-x86-64.so.2 /lib/ld-linux-x86-64.so.2

echo
echo "✅ gcompat with the three Factorio patches has been installed."
echo "▶ Try running Factorio now: ~/factorio/bin/x64/factorio"

