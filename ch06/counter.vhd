-- The counter of the Chapter 6 listing. Its width is a generic, which the
-- ghdl_verilog target sets with `generics = {"WIDTH": "8"}`.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library util_lib;
use util_lib.util.all;

entity counter is
  generic (
    WIDTH : positive := 4
  );
  port (
    clk : in  std_logic;
    rst : in  std_logic;
    q   : out std_logic_vector(WIDTH - 1 downto 0)
  );
end entity counter;

architecture rtl of counter is
  signal count : natural range 0 to 2 ** WIDTH - 1 := 0;
begin
  process (clk) is
  begin
    if rising_edge(clk) then
      if rst = '1' then
        count <= 0;
      else
        count <= next_count(count, WIDTH);
      end if;
    end if;
  end process;

  q <= std_logic_vector(to_unsigned(count, WIDTH));
end architecture rtl;
