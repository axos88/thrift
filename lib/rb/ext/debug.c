#include <ruby.h>
#include <constants.h>
#include <bytes.h>
#include <macros.h>

#include "debug.h"

int curdepth = 0;
int maxdepth = 0;
int debug_level = 0;

VALUE rb_set_debug(VALUE klass, VALUE level)
{
  debug_level = NUM2INT(level);

  return Qnil;
}

VALUE rb_get_debug(VALUE klass)
{
  return INT2NUM(debug_level);
}

VALUE rb_pred_debug(VALUE klass)
{
  return debug_level > 0 ? Qtrue : Qfalse;
}

VALUE rb_get_maxdepth(VALUE klass)
{
  return INT2NUM(maxdepth);
}

VALUE rb_get_curdepth(VALUE klass)
{
  return INT2NUM(curdepth);
}

void Init_debug()
{
  rb_define_module_function(thrift_module, "debug=", rb_set_debug, 1);
  rb_define_module_function(thrift_module, "debug",  rb_get_debug, 0);
  rb_define_module_function(thrift_module, "debug?", rb_pred_debug, 0);
  rb_define_module_function(thrift_module, "max_depth",  rb_get_maxdepth, 0);
  rb_define_module_function(thrift_module, "cur_depth",  rb_get_curdepth, 0);
}
