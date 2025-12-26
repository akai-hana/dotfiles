const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#0F0F14", /* black   */
  [1] = "#3F3F51", /* red     */
  [2] = "#912D33", /* green   */
  [3] = "#AE3234", /* yellow  */
  [4] = "#C0393A", /* blue    */
  [5] = "#47958C", /* magenta */
  [6] = "#B9C0A8", /* cyan    */
  [7] = "#e0ded0", /* white   */

  /* 8 bright colors */
  [8]  = "#9c9b91",  /* black   */
  [9]  = "#3F3F51",  /* red     */
  [10] = "#912D33", /* green   */
  [11] = "#AE3234", /* yellow  */
  [12] = "#C0393A", /* blue    */
  [13] = "#47958C", /* magenta */
  [14] = "#B9C0A8", /* cyan    */
  [15] = "#e0ded0", /* white   */

  /* special colors */
  [256] = "#0F0F14", /* background */
  [257] = "#e0ded0", /* foreground */
  [258] = "#e0ded0",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
