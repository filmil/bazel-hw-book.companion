-- The util_lib library of the Chapter 6 listing. It exists so that the
-- counter has a deps edge to follow.
package util is
  function next_count(count : natural; width : positive) return natural;
end package util;

package body util is
  function next_count(count : natural; width : positive) return natural is
  begin
    return (count + 1) mod (2 ** width);
  end function next_count;
end package body util;
