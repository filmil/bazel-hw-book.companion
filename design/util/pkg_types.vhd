-- A package the counter depends on. Its only job here is to be a
-- compilation unit that must be analyzed *before* its user, so the
-- derived-order claim of Chapter 1 has something to derive.
package pkg_types is
  constant COUNTER_WIDTH : natural := 8;
end package pkg_types;
