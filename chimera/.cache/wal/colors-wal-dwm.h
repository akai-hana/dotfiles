static const char norm_fg[] = "#e0ded0";
static const char norm_bg[] = "#0F0F14";
static const char norm_border[] = "#9c9b91";

static const char sel_fg[] = "#e0ded0";
static const char sel_bg[] = "#912D33";
static const char sel_border[] = "#e0ded0";

static const char urg_fg[] = "#e0ded0";
static const char urg_bg[] = "#3F3F51";
static const char urg_border[] = "#3F3F51";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
