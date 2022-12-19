

-- MUX in VHDL  : Conditional Signal Assignment

Y  <=  A when ( s = "00" ) else 
	B when ( s = "01" ) else 
	C when ( s = "10" ) else 
	D; 
	
	
  
-- MUX in VHDL  :  Selective Signal Assignment 

with  s select 
Y  <=  D0 when "00",
	D1 when "01",
	D2 when  "10",
	D3 when others; 
	
	
	
-- MUX in VHDL : if-elseif-else statements 

process (A,B,C,D,s) is 
begin 
	If ( s = "00" ) then 
		Y <= A; 
	elsif ( s = "01" ) then 
		Y <= B; 
	elsif  ( s = "10") then 
		Y <= C; 
	else 
		Y <= D 
	end if;
end process; 



-- MUX in VHDL : using a case-statement

mux: process (A,B,C,s) is 
begin 
	when "00" => Y <= A;
	when "01" => Y <= B;
	when "10" => Y <= C;
	when others => Y <= D;
  end case;
end process mux;






-- Flip flop -----------------------------------------------------------------------------
entity DFF_rstLow is
    port(
        Q : out std_logic;
        Clk,n_Rst,D :in std_logic);
    end DFF_rstLow;

architecture rtl of DFF_rstLow is
begin
    process(Clk,n_Rst)
    begin
        if(n_Rst='0') then
            Q <= '0';
        elsif(rising_edge(Clk)) then
            Q <= D;
        end if;
    end process;
end rtl;




-- Counter 16 ----------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_1164.ALL;

entity Counter16 is
	port( Clk, Ena, n_Rst: in std_logic;
		Q: out std_logic_vector(3 downto 0));
	end Counter16;
	
architecture rtl of Counter16 is
	signal Cnt_int: std_logic_vector(3 downto 0);
begin
	process(Clk, n_Rst)
	begin
		if n_Rst ='0' then
			Cnt_int <= (others => '0');
		elsif(rising_edge(Clk)) then
			if Ena='1' then
				Cnt_int <= Cnt_int + 1;
			end if;
		end if;
	end process;
	Q <= Cnt_int;
end rtl;




-- Counter 10 ----------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

    entity Counter16 is
        port( Clk, Ena, n_Rst: in std_logic;
            Q: out std_logic_vector(3 downto 0));
        end Counter16;

architecture rtl of Counter16 is
    signal Cnt_int: std_logic_vector(3 downto 0);
begin
    process(Clk,n_Rst)
    begin
        if n_Rst='0' then
            Cnt_int <= (others => '0');
        elsif(rising_edge(Clk)) then
            if Ena='1' then
                if Cnt_int="1001" then
                    Cnt_int <= (others => '0');
                else
                    Cnt_int <= Cnt_int + 1;
                end if;
            end if;
        end if;
    end process;
Q <= Cnt_int;
end rtl;



-- Generics Example -------------------------------------------------------------------------------
-- Consider a clocked 4:1 bus multiplexer 
-- What is the width of the data bus changes ? 
-- In this case, because make reset to the output, only the entity need to be changed 

entity busmux4to1 is
	generic (
		DATA_WIDTH : integer := 8
	);
	port (
		clk, n_Reset: in std_logic;
		A,B,C,D : in std_logic_vector(DATA_WIDTH-1 downto 0);
		S : in std_logic_vector(1 downto 0);
		Y : out std_logic_vector(DATA_WIDTH-1 downto 0)
	);
end busmux4to1;


architecture rtl of busmux4to1 is
begin
	sync_mux_p: process(clk, n_Reset)
	begin
		if n_Reset = '0' then
			Y <= (others => '0');
		elsif rising_edge(clk) then
			case S is
				when "00" => Y <= A;
				when "01" => Y <= B;
				when "10" => Y <= C;
				when others => Y <= D;
			end case;
		end if; --clk/rst
	end process sync_mux_p;
end architecture rtl



-- Generics and Hierarchy Examples

entity mux_top is
	port (
		sysclk: in std_logic;
		S: in std_logic_vector(1 downto 0);
		Q : out std_logic_vector(15 downto 0);
		Q_wide : out std_logic_vector(31 downto 0));
end mux_top;

architecture rtl of mux_top is
	component gen_busmux4to1 is
	generic ( DATA_WIDTH : integer := 8 );
	port (
		clk, n_Reset: in std_logic;
		A,B,C,D : in std_logic_vector(DATA_WIDTH-1 downto 0);
		S : in std_logic_vector(1 downto 0);
		Y : out std_logic_vector(DATA_WIDTH-1 downto 0)
	);
	end component gen_busmux4to1;

	signal E,F,G,H: std_logic_vector(15 downto 0);
	signal X,Y,Z,W: std_logic_vector(31 downto 0);
	signal n_Reset: std_logic;

begin
		n_Reset <= ‘1';
		i_busmux16: gen_busmux4to1
		generic map (
			DATA_WIDTH => 16
		)
	port map (n_Reset => n_Reset,
		clk => sysclk,
		A => E, B => F, C => G, D => H,
		S => S,
		Y => Q);

	i_busmux32: gen_busmux4to1
		generic map (
		DATA_WIDTH => 32
		)
	port map (n_Reset => n_Reset,
		clk => sysclk,
		A => X, B => Y, C => Z, D => W,
		S => S,
		Y => Q_wide);
end rtl;