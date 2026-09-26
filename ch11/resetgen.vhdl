-- Copied unchanged from rules_nvc 4.5.2, integration/sim/resetgen.vhdl (Apache 2.0).
library ieee; use ieee.std_logic_1164.all;

entity resetgen is
    generic(
        wait_time: time := 1 ns
        ; reset_duration: time := 2ns
    );
    port(
        rst: out std_logic
    );
end entity;

architecture sim of resetgen is

begin

    gen: process is
    begin
        wait for wait_time;
        rst <= '1';
        wait for reset_duration;
        rst <= '0';
        wait;
    end process;

end architecture;
