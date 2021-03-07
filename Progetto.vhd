library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;



entity project_reti_logiche is
port (
i_clk : in STD_LOGIC;
i_rst : in STD_LOGIC;
i_start : in STD_LOGIC;
i_data : in STD_LOGIC_VECTOR(7 downto 0);
o_address : out STD_LOGIC_VECTOR(15 downto 0);
o_done : out STD_LOGIC;
o_en : out STD_LOGIC;
o_we : out STD_LOGIC;
o_data : out STD_LOGIC_VECTOR (7 downto 0)
);
end project_reti_logiche;







architecture Behavioral of project_reti_logiche is

component datapathRL is       --component è un copia incolla dell'entity di DATAPATH. qua sto istanziando il compnente
    Port ( i_clk : in STD_LOGIC;
           i_rst : in STD_LOGIC;
           i_start : in STD_LOGIC;
           i_data : in STD_LOGIC_VECTOR (7 downto 0);
           o_data : out STD_LOGIC_VECTOR (7 downto 0);
           o_addr : out STD_LOGIC_VECTOR (15 downto 0); 
           r1_load : in STD_LOGIC;
           r2_load : in STD_LOGIC;
           rsu_load : in STD_LOGIC;
           rsu1_load : in STD_LOGIC;
           rco_load : in STD_LOGIC;
           rma_load : in STD_LOGIC;
           rm_load : in STD_LOGIC;
           rt_load : in STD_LOGIC;  
           rTS_load : in STD_LOGIC;
           r_sel2 : in STD_LOGIC; 
           iniz_sel : in STD_LOGIC; 
           mult_sel : in STD_LOGIC;
           addr_sel : in STD_LOGIC;
           compmin_sel : in STD_LOGIC;
           r_sel : in STD_LOGIC;
           o_end : out STD_LOGIC;
           finish : out STD_LOGIC;
           CZ : out STD_LOGIC);
end component; 

signal r1_load : STD_LOGIC;
signal r2_load : STD_LOGIC;
signal rsu_load : STD_LOGIC;
signal rsu1_load : STD_LOGIC;
signal rco_load : STD_LOGIC;
signal rma_load : STD_LOGIC;
signal rm_load : STD_LOGIC;
signal rpt_load : STD_LOGIC;
signal rd_load : STD_LOGIC;
signal rs_load : STD_LOGIC;
signal rt_load : STD_LOGIC; 
signal rTS_load : STD_LOGIC;
signal r_sel2 : STD_LOGIC; 
signal iniz_sel : STD_LOGIC; 
signal mult_sel : STD_LOGIC;
signal addr_sel : STD_LOGIC;
signal compmin_sel : STD_LOGIC;
signal r_sel : STD_LOGIC;    
signal o_end : STD_LOGIC;
signal finish : STD_LOGIC;    
signal CZ : STD_LOGIC;

type S is (S0,S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12,S13,S14,S15,S16,S17,S18,S19,S20,S21,S22,S23,S24,S25);
signal cur_state, next_state : S;


begin
 DATAPATH0: datapathRL port map( 
        i_clk,
        i_rst,
        i_start,
        i_data, 
        o_data,
        o_address, 
        r1_load,
        r2_load,
        rsu_load,
        rsu1_load,
        rco_load,
        rma_load,
        rm_load,
        rt_load,
        rTS_load,
        r_sel2,
        iniz_sel,
        mult_sel,
        addr_sel,
        compmin_sel,
        r_sel,       
        o_end,
        finish,
        CZ
    );



   process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            cur_state <= S0;
        elsif rising_edge(i_clk) then
            cur_state <= next_state;
        end if;
    end process;
    
    
    process(cur_state, i_start, o_end) -- FUNZIONE STATO PROSSIMO
    begin
        next_state <= cur_state;
        case cur_state is
           when S0 =>
                if i_start = '1' then
                    next_state <= S1;
                end if;
            when S1 =>
                next_state <= S2;
            when S2 =>
                next_state <= S3;
            when S3 =>            
                next_state <= S4;
            when S4 =>  
                next_state <= S25;
            when S25 =>  
                next_state <= S20;    
            when S20 =>
                if CZ = '1' then
                    next_state <= S5;
                else
                    next_state <= S23;
                end if;
            when S23 =>  
                next_state <= S24;
            when S24 =>  
                next_state <= S20;
            when S5 =>
               if o_end = '1' then
                    next_state <= S18;
                else if finish = '1' then
                        next_state <= S16;
                        else
                    next_state <= S21;
                end if;   
                end if;
            when S21 =>
                if o_end = '1' then
                    next_state <= S22;
                else
                    next_state <= S6;
                end if;
            when S22 =>
                next_state <= S7;
            when S6 =>
                if o_end = '1' then
                    next_state <= S7;
                else
                    next_state <= S6;
                end if;
            when S7 =>
                next_state <= S8;
            when S8 =>
                next_state <= S9;
            when S9 =>
                next_state <= S10;
            when S10 =>
                next_state <= S11;
            when S11 =>
                next_state <= S12;
            when S12 =>
                if o_end = '1' then
                    next_state <= S13;
                else
                    next_state <= S9;
                end if;
            when S13 => 
                next_state <= S14;
            when S14 =>
                next_state <= S15;
            when S15 =>
                next_state <= S16; 
            when S16 =>
                if i_start = '1' then
                    next_state <= S16;
                else
                    next_state <= S17;
                end if;
            when S17 =>
                if i_start = '1' then
                    next_state <= S1;
                else
                    next_state <= S0;
                end if;      
            when S18 =>
                next_state <= S19; 
            when S19 =>
                next_state <= S16;    
          end case;
    end process;
    
    
    
  process(cur_state)   -- FUNZIONE D'USCITA
    begin
        r1_load <= '0';
        r2_load <= '0';
        rsu_load <= '0';
        rsu1_load <= '0';
        rco_load <= '0';
        rma_load <= '0';
        rm_load <= '0';
        rt_load <= '0';
        rTS_load <= '0';
        r_sel2 <= '0';
        iniz_sel <= '0';
        mult_sel <= '0';
        addr_sel <= '0';
        r_sel <= '0';
        compmin_sel <= '0';
        o_en <= '0';
        o_we <= '0';
        o_done <= '0';


case cur_state is
            when S0 =>
            when S1 =>
                rco_load <= '1';
            when S2 =>
                rco_load <= '1';
                rma_load <= '1';
                rm_load <= '1';
                iniz_sel <= '1';
                r_sel <= '1'; 
                o_en <= '1';
            when S3 =>
                r1_load <= '1';
                iniz_sel <= '1';
                o_en <= '1';
                rco_load <= '1';             
            when S4 =>
                r2_load <= '1';
                iniz_sel <= '1';
                o_en <= '1';
                rco_load <= '1';
            when S5 =>
                rsu1_load <= '1';
                rma_load <= '1';
                rm_load <= '1';
            when S6 =>
                rma_load <= '1';
                rm_load <= '1';
                rco_load <= '1';
                iniz_sel <= '1';
                o_en <= '1';
            when S7 =>
                mult_sel <= '1';
                rsu_load <= '1';
                rco_load <= '1';
                rma_load <= '1'; 
                rm_load <= '1';
            when S8 =>
                o_en <= '1';
            when S9 =>
                o_en <= '1';
            when S10 =>
                rt_load <= '1';  
            when S11 =>
                addr_sel <= '1';
                rsu_load <= '1';
                rco_load <= '1';
                iniz_sel <= '1';  
                o_en <= '1';
                o_we <= '1';
            when S12 =>
            when S13 =>
                o_en <= '1';
            when S14 =>
                rt_load <= '1';
             when S15 =>     
                addr_sel <= '1';
                o_en <= '1';
                o_we <= '1';
             when S16 =>     
                o_done <= '1'; 
             when S17 =>     
                o_done <= '0';
             when S18 =>
                mult_sel <= '1';
                rsu_load <= '1';
                rco_load <= '1';    
             when S19 =>    
                addr_sel <= '1';
                o_en <= '1';
                o_we <= '1';
                compmin_sel <= '1';
            when S20 =>
            when S21 =>
                rco_load <= '1';
                iniz_sel <= '1';
                o_en <= '1';
            when S22 =>
                rma_load <= '1';
                rm_load <= '1';
            when S23 =>
                r_sel2 <= '1';
                rTS_load <= '1';
                r2_load <= '1';
            when S25 =>
            when S24 =>
                r_sel2 <= '1';
            
        end case;
    end process;

end Behavioral;


-------------------------------------------------------------------------------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;




entity datapathRL is --datapath è un componente. la entity sono i fili del datapath che porto all'esterno
     Port ( i_clk : in STD_LOGIC;
           i_rst : in STD_LOGIC;
           i_start : in STD_LOGIC;
           i_data : in STD_LOGIC_VECTOR (7 downto 0);
           o_data : out STD_LOGIC_VECTOR (7 downto 0);
           o_addr : out STD_LOGIC_VECTOR (15 downto 0);
           r1_load : in STD_LOGIC;
           r2_load : in STD_LOGIC;
           rsu_load : in STD_LOGIC;             --forse serve aggiungere o_end
           rsu1_load : in STD_LOGIC;
           rco_load : in STD_LOGIC;
           rma_load : in STD_LOGIC;
           rm_load : in STD_LOGIC;
           rt_load : in STD_LOGIC;  
           rTS_load : in STD_LOGIC;
           r_sel2 : in STD_LOGIC;
           iniz_sel : in STD_LOGIC; 
           mult_sel : in STD_LOGIC;
           addr_sel : in STD_LOGIC;
           compmin_sel : in STD_LOGIC;
           r_sel : in STD_LOGIC;
           o_end : out STD_LOGIC; 
           finish : out STD_LOGIC;
           CZ : out STD_LOGIC);
end datapathRL;





architecture Behavioral of datapathRL is 
signal o_reg1 : STD_LOGIC_VECTOR (7 downto 0);
signal o_reg2 : STD_LOGIC_VECTOR (7 downto 0);
signal o_regsum1 : STD_LOGIC_VECTOR (15 downto 0);
signal o_regsum2 : STD_LOGIC_VECTOR (15 downto 0);
signal o_regcount : STD_LOGIC_VECTOR (15 downto 0);
signal o_regmax : STD_LOGIC_VECTOR (7 downto 0);
signal o_regmin : STD_LOGIC_VECTOR (7 downto 0);
--signal o_regdelta : STD_LOGIC_VECTOR (7 downto 0);
--signal o_regshift : STD_LOGIC_VECTOR (7 downto 0);
--signal o_regpretemp : STD_LOGIC_VECTOR (7 downto 0);
signal o_regtemp : STD_LOGIC_VECTOR (15 downto 0);
signal sum1 : STD_LOGIC_VECTOR(15 downto 0);
signal sum2 : STD_LOGIC_VECTOR(15 downto 0);
signal sum3 : STD_LOGIC_VECTOR(15 downto 0);
signal sum4 : STD_LOGIC_VECTOR(8 downto 0);   -- ATTENZIONE, è SU 9 BIT 
signal sum5 : STD_LOGIC_VECTOR(15 downto 0);
signal sub1 : STD_LOGIC_VECTOR(7 downto 0);
signal sub2 : STD_LOGIC_VECTOR(7 downto 0);
signal sub3 : STD_LOGIC_VECTOR(7 downto 0);
signal sub4 : STD_LOGIC_VECTOR(7 downto 0);
signal o_regTS : STD_LOGIC_VECTOR(15 downto 0);
signal shift : STD_LOGIC_VECTOR(15 downto 0);
signal log : STD_LOGIC_VECTOR(7 downto 0);

signal mux1 : STD_LOGIC_VECTOR(15 downto 0);
signal mux2 : STD_LOGIC_VECTOR(15 downto 0);
signal mux3 : STD_LOGIC_VECTOR(15 downto 0);
signal mux5 : STD_LOGIC_VECTOR(7 downto 0);
signal mux6 : STD_LOGIC_VECTOR(7 downto 0);
signal mux7 : STD_LOGIC_VECTOR(7 downto 0);
signal mux8 : STD_LOGIC_VECTOR(7 downto 0);
signal mux9 : STD_LOGIC_VECTOR(7 downto 0);
signal compmin : STD_LOGIC_VECTOR(7 downto 0);

signal comp1_sel : STD_LOGIC;
signal comp2_sel : STD_LOGIC;


begin

------------------------------------------------------------REGISTRI--------------------------------
 process(i_clk, i_rst) --PROCESS CHE DESCIRVE REGISTRO 1
    begin
        if(i_rst = '1') then
            o_reg1 <= "00000000";
        elsif rising_edge(i_clk) then
            if(r1_load = '1') then
                o_reg1 <= i_data;
            end if;
        end if;
    end process;
    
    
     process(i_clk, i_rst) --PROCESS CHE DESCIRVE REGISTRO 2
    begin
        if(i_rst = '1') then
            o_reg2 <= "00000000";
        elsif rising_edge(i_clk) then
            if(r2_load = '1') then
                o_reg2 <= mux9;
            end if;
        end if;
    end process;


 process(i_clk, i_rst) --PROCESS CHE DESCIRVE REGISTRO regsum1
    begin
        if(i_rst = '1') then
            o_regsum1 <= "0000000000000000";
        elsif rising_edge(i_clk) then
            if(rsu1_load = '1') then
                o_regsum1 <= sum1;
            end if;
        end if;
    end process;


 process(i_clk, i_rst) --PROCESS CHE DESCIRVE REGISTRO count
    begin
        if(i_rst = '1') then
            o_regcount <= "0000000000000000";
        elsif rising_edge(i_clk) then
            if(rco_load = '1') then
                o_regcount <= sum2;
            end if;
        end if;
    end process;


 process(i_clk, i_rst) --PROCESS CHE DESCIRVE REGISTRO sum2
    begin
        if(i_rst = '1') then
            o_regsum2 <= "0000000000000000";
        elsif rising_edge(i_clk) then
            if(rsu_load = '1') then
                o_regsum2 <= sum3;
            end if;
        end if;
    end process;
    
    
     process(i_clk, i_rst) --PROCESS CHE DESCIRVE REGISTRO max
    begin
        if(i_rst = '1') then
            o_regmax <= "00000000";
        elsif rising_edge(i_clk) then
            if(rma_load = '1') then
                o_regmax <= mux6;
            end if;
        end if;
    end process;
    
    
     process(i_clk, i_rst) --PROCESS CHE DESCIRVE REGISTRO min
    begin
        if(i_rst = '1') then
            o_regmin <= "00000000";
        elsif rising_edge(i_clk) then
            if(rm_load = '1') then
                o_regmin <= mux8;
            end if;
        end if;
    end process;
    
    

    
    
         process(i_clk, i_rst) --PROCESS CHE DESCIRVE REGISTRO temp
    begin
        if(i_rst = '1') then
            o_regtemp <= "0000000000000000";
        elsif rising_edge(i_clk) then
            if(rt_load = '1') then
                o_regtemp <= shift;
            end if;
        end if;
    end process;
    
    
    
       process(i_clk, i_rst, i_start) --PROCESS CHE DESCIRVE REGISTRO TS
    begin
        if(i_rst = '1' or i_start = '0') then
            o_regTS <= "0000000000000000";
        elsif rising_edge(i_clk) then
            if(rTS_load = '1') then
                o_regTS <= sum5;
            end if;
        end if;
    end process;
---------------------------------------------------------REGISTRI---------------------------------


---------------------------------------------------------MULTIPLEXER---------------------------------
    

 with mult_sel select     --MULTIPLEXER
        mux1 <= "1111111111111111" when '0',
                 "0000000000000001" when '1',
                 "XXXXXXXXXXXXXXXX" when others;
                    
with iniz_sel select    
        mux2 <= mux1 when '0',
                o_regcount when '1',
                "XXXXXXXXXXXXXXXX" when others;
with iniz_sel select    
        mux3 <= o_regsum1 when '0',
                o_regsum2 when '1',
                "XXXXXXXXXXXXXXXX" when others;
                
                    
with addr_sel select    --mux4  
        o_addr <= o_regcount when '0',
                  o_regsum2 when '1',
                  "XXXXXXXXXXXXXXXX" when others;
                  
with comp1_sel select     
        mux5 <= i_data when '0',
                o_regmax when '1',
                "XXXXXXXX" when others;


with r_sel select     
        mux6 <= mux5 when '0',
                "00000000" when '1',
                "XXXXXXXX" when others;


with comp2_sel select     
        mux7 <=i_data when '0',
                o_regmin when '1',
                "XXXXXXXX" when others;


with r_sel select     
        mux8 <= mux7 when '0',
                "11111111" when '1',
                "XXXXXXXX" when others;
                
with compmin_sel select     
        o_data <= compmin when '0',
                "00000000" when '1',
                "XXXXXXXX" when others;      
                
                
with r_sel2 select     
        mux9 <= i_data when '0',
                sub4 when '1',
                "XXXXXXXX" when others;
-----------------------------------------------------------MULTIPLEXER------------------------------


---------------------------------------------------------OPERESCIONSz-------------------------------


sum1 <= "0000000000000001" + o_regTS;

sum2 <= "0000000000000001" + mux2;

sum3 <= "0000000000000001" + mux3;

sum4 <= "000000001" + ('0' & sub3);     -- ATTENZIONE, è SU 9 BIT LA SOMMA

sum5 <= ("00000000" & o_reg1) + o_regTS;

sub1 <= i_data - o_regmin;

sub2 <= "00001000" - log;

sub3 <= o_regmax - o_regmin;

sub4 <= (o_reg2 - "00000001");-- when (o_reg2 /= "00000000") else o_reg2;


---------------------------------------------------------OPERESCIONSz-------------------------------


----------------------------------------------------------blocchi logici--------------------------


o_end <= '1' when (o_regcount = o_regsum1 or sum1 = "0000000000000010") else '0'; --COMPARAORE

--o_end <= '1' when (sum1 = "0000000000000010") else '0';


comp1_sel <= '1' when (o_regmax > i_data) else '0';

comp2_sel <= '1' when (o_regmin < i_data) else '0';

finish <= '1' when (o_regTS = "0000000000000000") else '0';

CZ <= '1' when (o_reg2 = "00000000") else '0';

process(sum4) 
    begin
    log <= "00000000";
        if( sum4 = "00000001") then
            log <= "00000000";
        end if;
        if(sum4>= "00000010" and sum4< "00000100") then
                    log <= "00000001";
                end if;
        if(sum4>= "00000100" and sum4< "00001000") then
                    log <= "00000010";
                end if;
        if(sum4>= "00001000" and sum4< "00010000") then
                    log <= "00000011";
                end if;        
        if(sum4>= "00010000" and sum4< "00100000") then
                    log <= "00000100";
                end if;
        if(sum4>= "00100000" and sum4< "01000000") then
                    log <= "00000101";
                end if;    
        if(sum4>= "01000000" and sum4< "10000000") then
                    log <= "00000110";
                end if;                
        if(sum4 >= "10000000" and sum4<= "11111111") then
                    log <= "00000111";
                end if;
        if(sum4 > "11111111") then
                    log <= "00001000";
                end if;
    end process;


process(sub1) 
    begin
    shift <= "0000000000000000";
        if( sub2 = "00000000") then
            shift <= "00000000" & sub1;
        end if;
        if( sub2 = "00000001") then
            shift <= "0000000" & sub1 & '0';
        end if;
        if( sub2 = "00000010" ) then
             shift <= "000000" & sub1 & "00";
                end if;
        if( sub2 = "00000011" ) then
             shift <= "00000" & sub1 & "000";
                end if;
        if( sub2 = "00000100" ) then
             shift <= "0000" & sub1 & "0000";
                end if;        
        if( sub2 = "00000101" ) then
             shift <= "000" & sub1 & "00000";
                end if;
        if( sub2 = "00000110" ) then
              shift <= "00" & sub1 & "000000";
                end if;    
        if( sub2 = "00000111" ) then
              shift <= "0" & sub1 & "0000000";
                end if;                
        if( sub2 = "00001000" ) then
               shift <= sub1 & "00000000";
                end if;
    end process;



compmin <= "11111111" when ( "0000000011111111" < o_regtemp) else o_regtemp(7 downto 0);

end Behavioral;