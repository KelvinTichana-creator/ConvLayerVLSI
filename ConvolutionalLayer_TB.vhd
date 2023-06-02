library ieee;
use ieee.std_logic_1164.all;

entity ConvolutionalLayer_TB is
end ConvolutionalLayer_TB;

architecture Behavioral of ConvolutionalLayer_TB is
    constant INPUT_WIDTH    : integer := 8;
    constant WEIGHT_WIDTH   : integer := 8;
    constant OUTPUT_WIDTH   : integer := 16;
    constant FILTER_SIZE    : integer := 3;
    constant STRIDE         : integer := 1;
    constant INPUT_CHANNELS : integer := 1;
    constant OUTPUT_CHANNELS: integer := 1;
    
    signal clk          : std_logic := '0';
    signal reset        : std_logic := '0';
    signal input_valid  : std_logic := '0';
    signal input_data   : std_logic_vector(INPUT_WIDTH-1 downto 0) := (others => '0');
    signal output_valid : std_logic;
    signal output_data  : std_logic_vector(OUTPUT_WIDTH-1 downto 0);
    
    -- Add signals for test stimuli and expected outputs if necessary

    component ConvolutionalLayer is
        generic (
            INPUT_WIDTH    : integer := 8;
            WEIGHT_WIDTH   : integer := 8;
            OUTPUT_WIDTH   : integer := 16;
            FILTER_SIZE    : integer := 3;
            STRIDE         : integer := 1;
            INPUT_CHANNELS : integer := 1;
            OUTPUT_CHANNELS: integer := 1
        );
        port (
            clk          : in std_logic;
            reset        : in std_logic;
            input_valid  : in std_logic;
            input_data   : in std_logic_vector(INPUT_WIDTH-1 downto 0);
            output_valid : out std_logic;
            output_data  : out std_logic_vector(OUTPUT_WIDTH-1 downto 0)
        );
    end component;

begin
    -- Instantiate the ConvolutionalLayer module
    UUT: ConvolutionalLayer
        generic map (
            INPUT_WIDTH    => INPUT_WIDTH,
            WEIGHT_WIDTH   => WEIGHT_WIDTH,
            OUTPUT_WIDTH   => OUTPUT_WIDTH,
            FILTER_SIZE    => FILTER_SIZE,
            STRIDE         => STRIDE,
            INPUT_CHANNELS => INPUT_CHANNELS,
            OUTPUT_CHANNELS => OUTPUT_CHANNELS
        )
        port map (
            clk          => clk,
            reset        => reset,
            input_valid  => input_valid,
            input_data   => input_data,
            output_valid => output_valid,
            output_data  => output_data
        );
        
    -- Clock process
    process
    begin
        while now < 100 ns loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process;
    
    -- Stimulus process
    process
    begin
        reset <= '1';
        wait for 10 ns;
        reset <= '0';
        wait for 10 ns;

        -- Send test stimuli and expected outputs here
        input_data <= "00001111";  -- Example input data
        input_valid <= '1';  -- Assert input_valid

        wait for 10 ns;

        -- Check the expected output
        if output_valid = '1' then
            if output_data = "0000000000000001" then  -- Example expected output
                -- Output is correct
                report "Output is correct.";
            else
                -- Output is incorrect
                report "Output is incorrect.";
            end if;
        else
            -- Output is not valid
            report "Output is not valid.";
        end if;

        wait;
    end process;

end Behavioral;
