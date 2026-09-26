-- A self-checking testbench for the Chapter 1 counter. It releases reset,
-- waits ten clock edges, and fails the simulation unless q reads 10.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_tb is
end entity counter_tb;

architecture sim of counter_tb is
  signal clk : std_logic := '0';
  signal rst : std_logic := '1';
  signal q   : std_logic_vector(7 downto 0);
begin
  dut : entity work.counter
    port map (clk => clk, rst => rst, q => q);

  clk <= not clk after 5 ns;

  stimulus : process is
  begin
    wait until rising_edge(clk);
    rst <= '0';
    for i in 1 to 10 loop
      wait until rising_edge(clk);
    end loop;
    wait for 1 ns;
    assert unsigned(q) = 10
      report "expected q = 10, got " & integer'image(to_integer(unsigned(q)))
      severity failure;
    std.env.finish;
  end process stimulus;
end architecture sim;
