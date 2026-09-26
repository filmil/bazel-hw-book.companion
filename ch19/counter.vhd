-- The Chapter 1 counter, with its width taken from dep_lib.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library dep_lib;
use dep_lib.consts.all;

entity counter is
  port (
    clk : in  std_logic;
    rst : in  std_logic;
    q   : out std_logic_vector(COUNTER_WIDTH - 1 downto 0)
  );
end entity counter;

architecture rtl of counter is
  signal count : unsigned(COUNTER_WIDTH - 1 downto 0) := (others => '0');
begin
  process (clk) is
  begin
    if rising_edge(clk) then
      if rst = '1' then
        count <= (others => '0');
      else
        count <= count + 1;
      end if;
    end if;
  end process;

  q <= std_logic_vector(count);
end architecture rtl;
