-- The design Chapter 1 tours: an 8-bit synchronous counter.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
  port (
    clk : in  std_logic;
    rst : in  std_logic;
    q   : out std_logic_vector(7 downto 0)
  );
end entity counter;

architecture rtl of counter is
  signal count : unsigned(7 downto 0) := (others => '0');
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
