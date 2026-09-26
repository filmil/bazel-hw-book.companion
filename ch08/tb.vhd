-- The testbench of the Chapter 8 listing. The STIM_FILE generic receives
-- the path of stim.dat through $(location) expansion at elaboration.
entity tb is
  generic (
    STIM_FILE : string := "unset"
  );
end entity tb;

architecture sim of tb is
begin
  report_path : process is
  begin
    report "stimulus file: " & STIM_FILE;
    wait;
  end process report_path;
end architecture sim;
