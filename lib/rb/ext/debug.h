#ifndef __DEBUG_H__
#define __DEBUG_H__

#define DEPTH_INCREMENT 2

extern int curdepth;
extern int maxdepth;
extern int debug_level;

#define LVL_CRITICAL 0
#define LVL_ERROR 1
#define LVL_WARN 2
#define LVL_INFO 3
#define LVL_LOG 4
#define LVL_DEBUG 5

#define DEBUG_MSG(lvl, fmt, ...) ((debug_level >= lvl) ? printf("%*s", curdepth, ""), printf(fmt, ##__VA_ARGS__), printf("\n") : 0)

#define DEBUGF(fmt, ...) DEBUG_MSG(LVL_DEBUG, fmt, ##__VA_ARGS__)
#define LOGF(fmt, ...) DEBUG_MSG(LVL_LOG, fmt, ##__VA_ARGS__)
#define INFOF(fmt, ...) DEBUG_MSG(LVL_INFO, fmt, ##__VA_ARGS__)
#define WARNF(fmt, ...) DEBUG_MSG(LVL_WARN, fmt, ##__VA_ARGS__)
#define ERRORF(fmt, ...) DEBUG_MSG(LVL_ERROR, fmt, ##__VA_ARGS__)
#define CRITICALF(fmt, ...) DEBUG_MSG(LVL_CRITICAL, fmt, ##__VA_ARGS__)

#define DEBUG_FUNCTION_ENTRY() DEBUGF("->%s:%s", __FILE__, __FUNCTION__), curdepth += DEPTH_INCREMENT, maxdepth = curdepth > maxdepth ? curdepth : maxdepth
#define DEBUG_FUNCTION_EXIT()  curdepth -= DEPTH_INCREMENT, DEBUGF("%s:%s", __FILE__, __FUNCTION__)
#define DEBUG_FUNCTION_PROGRESS() DEBUGF("%s, %s:%d", __FILE__, __FUNCTION__, __LINE__)

void Init_debug();

#endif
