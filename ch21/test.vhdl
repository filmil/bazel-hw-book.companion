-- Copied unchanged from rules_vunit 1.3.4, integration/test.vhdl (Apache 2.0).
library vunit_lib;
context vunit_lib.vunit_context;

entity tb is
    generic(
        --! Default vunit runner configuration.
        runner_cfg: string := runner_cfg_default
    );
end entity;

architecture sim of tb is
begin
    process
        variable logger : logger_t := get_logger("test/UART");
    begin
        test_runner_setup(runner, runner_cfg);
        while test_suite loop
            if run("a") then
                info(logger, "Hello world!");
                check_true(true, "oops");
            end if;
            if run("b") then
                info(logger, "Hello world 2!");
                check_true(true, "oops");
            end if;
        end loop;
        test_runner_cleanup(runner);
    end process;
end architecture;

architecture sim2 of tb is
begin
    process begin
        test_runner_setup(runner, runner_cfg);
        check_true(true, "oops");
        test_runner_cleanup(runner);
    end process;
end architecture;

configuration tb_cfg_default of tb is
    for sim end for;
end configuration;
