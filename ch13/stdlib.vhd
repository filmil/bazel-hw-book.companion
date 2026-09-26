-- A stand-in for GRLIB's stdlib.vhd. It uses the two packages before it
-- in the ordered list, so the order matters.
use work.version.all;
use work.config.all;

package stdlib is
  constant stdlib_version : integer := grlib_version;
  constant stdlib_enabled : boolean := CFG_ENABLE;
end package stdlib;
