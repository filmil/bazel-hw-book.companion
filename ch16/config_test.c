/* Checks that config.h, generated from ch16/Kconfig by rules_kconfig,
 * reflects the Kconfig defaults. */
#include <stdio.h>
#include <string.h>

#include "config.h"

int main(void) {
  printf("CONFIG_ACTIVE_DESIGN_PREFIX=%s\n", CONFIG_ACTIVE_DESIGN_PREFIX);
  if (strcmp(CONFIG_ACTIVE_DESIGN_PREFIX, "leon3") != 0) return 1;
#ifndef CONFIG_USE_FPU
  return 1;
#endif
  return 0;
}
