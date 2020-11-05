library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use work.all;

entity peripheral_LED is
    generic (
        LEN  : natural := 4
    );
    port (
        -- Gloabals
        clk                : in  std_logic                     := '0';             
        reset              : in  std_logic                     := '0';             

        -- I/Os
        LEDs               : out std_logic_vector(LEN - 1 downto 0) := (others => '0');

        -- Avalion Memmory Mapped Slave
        avs_address     : in  std_logic_vector(3 downto 0)  := (others => '0'); 
        avs_read        : in  std_logic                     := '0';             
        avs_readdata    : out std_logic_vector(31 downto 0) := (others => '0'); 
        avs_write       : in  std_logic                     := '0';             
        avs_writedata   : in  std_logic_vector(31 downto 0) := (others => '0')
    );
end entity peripheral_LED;

architecture rtl of peripheral_LED is

component stepmotor is
--  generic (
--    CLK_FREQ : natural := 50000000
--  );
    port (
        -- Gloabals
        clk   : in  std_logic;

        -- controls
        en      : in std_logic;                     -- 1 on/ 0 of
        dir     : in std_logic;                     -- 1 clock wise
        vel     : in std_logic_vector(1 downto 0);  -- 00: low / 11: fast

        -- I/Os
        phases  : out std_logic_vector(3 downto 0)
  );
end component;

	signal en, dir: std_logic := '0';
	signal vel : std_logic_vector(1 downto 0) := "00";

begin

	c1 : stepmotor port map(clk => clk, en => en, dir => dir, vel => vel, phases => LEDs );

  process(clk)
  begin
    if(rising_edge(clk)) then
        if(avs_address = "0001") then                  -- REG_DATA
            if(avs_write = '1') then
				  en <= avs_writedata(0);
				  dir <= avs_writedata(1);
				  vel <= avs_writedata(3 downto 2);
            end if;
        end if;
    end if;
  end process;

end rtl;