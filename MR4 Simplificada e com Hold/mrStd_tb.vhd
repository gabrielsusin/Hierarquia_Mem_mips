-------------------------------------------------------------------------
--
-- 32 bits PROCESSOR TESTBENCH    LITTLE  ENDIAN      13/october/2004
--
-- It must be observed that the processor is hold in reset
-- (rstCPU <= '1') at the start of simulation, being activated
-- (rstCPU <= '0') just after the end of the object file reading be the
-- testbench.
--
-- This testbench employs two memories implying a HARVARD organization
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.Std_Logic_1164.all;

package aux_functions is  

   subtype reg32  is std_logic_vector(31 downto 0);
   subtype reg16  is std_logic_vector(15 downto 0);
   subtype reg8   is std_logic_vector( 7 downto 0);
   subtype reg4   is std_logic_vector( 3 downto 0);

   -- defini��o do tipo 'memory', que ser� utilizado para as mem�rias de dados/instru��es
   constant MEMORY_SIZE : integer := 2048;     
   type memory is array (0 to MEMORY_SIZE) of reg8;
	
	
	-- defini��o do tipo 'asc_mem', que ser� utilizado para as mem�rias cache L2
	constant L2_SIZE : integer := 7;
	type asc_mem is array (0 to L2_SIZE) of std_logic_vector(26 downto 0);
	
	type l2_mem is array (0 to L2_SIZE) of std_logic_vector(256 downto 0);

   constant TAM_LINHA : integer := 200;
   
   function CONV_VECTOR( letra : string(1 to TAM_LINHA);  pos: integer ) return std_logic_vector;
   
end aux_functions;

package body aux_functions is

  --
  -- converte um caracter de uma dada linha em um std_logic_vector
  --
  function CONV_VECTOR( letra:string(1 to TAM_LINHA);  pos: integer ) return std_logic_vector is         
     variable bin: reg4;
   begin
      case (letra(pos)) is  
              when '0' => bin := "0000";
              when '1' => bin := "0001";
              when '2' => bin := "0010";
              when '3' => bin := "0011";
              when '4' => bin := "0100";
              when '5' => bin := "0101";
              when '6' => bin := "0110";
              when '7' => bin := "0111";
              when '8' => bin := "1000";
              when '9' => bin := "1001";
              when 'A' | 'a' => bin := "1010";
              when 'B' | 'b' => bin := "1011";
              when 'C' | 'c' => bin := "1100";
              when 'D' | 'd' => bin := "1101";
              when 'E' | 'e' => bin := "1110";
              when 'F' | 'f' => bin := "1111";
              when others =>  bin := "0000";  
      end case;
     return bin;
  end CONV_VECTOR;

end aux_functions;     

--------------------------------------------------------------------------
-- Module implementing a behavioral model of an ASYNCHRONOUS INTERFACE RAM
--------------------------------------------------------------------------
library IEEE;
use ieee.std_logic_1164.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use work.aux_functions.all;

entity RAM_mem_Data is
      generic(  START_ADDRESS: reg32 := (others=>'0')  );
      port( ce_n, we_n, oe_n, bw: in std_logic;    address: in reg32;   data: inout reg32);
end RAM_mem_Data;

architecture RAM_mem_Data of RAM_mem_Data is 
   signal RAM : memory;
   signal tmp_address: reg32;
   alias  low_address: reg16 is tmp_address(15 downto 0);    --  baixa para 16 bits devido ao CONV_INTEGER --
begin     

   tmp_address <= address - START_ADDRESS;   --  offset do endere�amento  -- 
   
   -- writes in memory ASYNCHRONOUSLY  -- LITTLE ENDIAN -------------------
   process(ce_n, we_n, low_address, data)
     begin
       if ce_n='0' and we_n='0' then
          if CONV_INTEGER(low_address)>=0 and CONV_INTEGER(low_address+3)<=MEMORY_SIZE then
               if bw='1' then
                   RAM(CONV_INTEGER(low_address+3)) <= data(31 downto 24);
                   RAM(CONV_INTEGER(low_address+2)) <= data(23 downto 16);
                   RAM(CONV_INTEGER(low_address+1)) <= data(15 downto  8);
               end if;
               RAM(CONV_INTEGER(low_address  )) <= data( 7 downto  0); 
          end if;
         end if;   
    end process;   
    
   -- read from memory
   process(ce_n, oe_n, low_address)
   begin
       if ce_n='0' and oe_n='0' and
          CONV_INTEGER(low_address)>=0 and CONV_INTEGER(low_address+3)<=MEMORY_SIZE then
            data(31 downto 24) <= RAM(CONV_INTEGER(low_address+3));
            data(23 downto 16) <= RAM(CONV_INTEGER(low_address+2));
            data(15 downto  8) <= RAM(CONV_INTEGER(low_address+1));
            data( 7 downto  0) <= RAM(CONV_INTEGER(low_address  ));
        else
            data(31 downto 24) <= (others=>'Z');
            data(23 downto 16) <= (others=>'Z');
            data(15 downto  8) <= (others=>'Z');
            data( 7 downto  0) <= (others=>'Z');
        end if;
   end process;   

end RAM_mem_Data;

--------------------------------------------------------------------------
-- Module implementing a behavioral model of a SYNCHRONOUS INTERFACE RAM
--------------------------------------------------------------------------
library IEEE;
use ieee.std_logic_1164.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use work.aux_functions.all;

entity RAM_mem_Instr is
      generic(  START_ADDRESS: reg32 := (others=>'0')  );
      port( ce_n, we_n, oe_n, bw, ck: in std_logic; hit: out std_logic;   address: in reg32;   data: inout reg32);
end RAM_mem_Instr;

architecture RAM_mem_Instr of RAM_mem_Instr is
	signal preHit: std_logic := '0';
   signal RAM : memory;
   signal tmp_address: reg32;
	signal f_hold: std_logic;
   alias  low_address: reg16 is tmp_address(15 downto 0);    --  baixa para 16 bits devido ao CONV_INTEGER --
begin     

   tmp_address <= address - START_ADDRESS;   --  offset do endere�amento  -- 
	
	hit <= preHIT;
	--hit <= ck when ce_n = '0' else '0';
	
   
   -- writes in memory SYNCHRONOUSLY  -- LITTLE ENDIAN -------------------
   process(ce_n, we_n, low_address, data)
     begin
       if ce_n='0' and we_n='0' then
          if CONV_INTEGER(low_address)>=0 and CONV_INTEGER(low_address+3)<=MEMORY_SIZE then
               if bw='1' then
                   RAM(CONV_INTEGER(low_address+3)) <= data(31 downto 24);
                   RAM(CONV_INTEGER(low_address+2)) <= data(23 downto 16);
                   RAM(CONV_INTEGER(low_address+1)) <= data(15 downto  8);
               end if;
               RAM(CONV_INTEGER(low_address  )) <= data( 7 downto  0); 
          end if;
         end if;   
    end process;   
    
   -- read from memory
   process(ce_n, oe_n, low_address, ck)
     begin
       if ce_n='0' and oe_n='0' and
          CONV_INTEGER(low_address)>=0 and CONV_INTEGER(low_address+3)<=MEMORY_SIZE then
			if ck'event and ck = '1' then
				preHIT <= '1';
            data(31 downto 24) <= RAM(CONV_INTEGER(low_address+3));
            data(23 downto 16) <= RAM(CONV_INTEGER(low_address+2));
            data(15 downto  8) <= RAM(CONV_INTEGER(low_address+1));
            data( 7 downto  0) <= RAM(CONV_INTEGER(low_address  ));
			elsif ck'event and ck = '0' then
				preHIT <= '0';
			end if;
       else
          data(31 downto 24) <= (others=>'Z');
          data(23 downto 16) <= (others=>'Z');
          data(15 downto  8) <= (others=>'Z');
          data( 7 downto  0) <= (others=>'Z');
       end if;
   end process;   

end RAM_mem_Instr;


--------------------------------------------------------------------------
-- Module implementing a behavioral model of a CACHE L2
--------------------------------------------------------------------------
library IEEE;
use ieee.std_logic_1164.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use work.aux_functions.all;

entity Cache_L2 is
      port(
		ce_n, ck, hitMem: in std_logic;
		hit, miss: out std_logic;
		addressFront: in reg32;
		addressBack: out reg32;
		dataFront: inout reg32;
		dataBack: in reg32);
end Cache_L2;

architecture Cache_L2 of Cache_L2 is 
	--signal state: integer;
	signal hitCheck: std_logic_vector(7 downto 0) := (others => '0');
	signal wordBuffer: std_logic_vector(256 downto 0) := (others => '0');
   signal TAG : asc_mem;
	signal dataCache: l2_mem := (others => wordBuffer);
	signal update: std_logic := '0';
	signal preHIT, preMISS: std_logic;
	signal wordID: std_logic_vector(3 downto 0) := (others => '0');
	
begin     

	hit <= preHIT and ck;
	
	miss <= preMiss;
	
	process(update)
	variable state: integer := 0;
	begin
		if update'event and update = '1' then
			TAG(state) <= addressFront(31 downto 5);
			DATACACHE(state) <= wordBuffer;
			if state < 8 then
				state := state + 1;
			else 
				state := 0;
			end if;
		end if;
	end process;


	process(ck)
	begin
		if ck'event and ck = '0' then
			hitL:for i in 0 to 7 loop
				if TAG(i) = addressFront(31 downto 5) and DATACACHE(i)(256) = '1' then
					hitCheck(i) <= '1';
				else 
					hitCheck(i) <= '0';
				end if;
			end loop hitL;
		end if;
	end process;



	--hitL:for i in 0 to 7 generate 
	--	hitCheck(i) <= '1' when TAG(i) = address(31 downto 3) else '0';
   --end generate hitL;
	
	preHIT <= '1' when hitCheck /= 0 else '0';
	
	preMISS <= not(preHIT);
	
	process(ck, ce_n)
	begin
		if ce_n = '0' then
			if ck'event and ck = '1' then
			
				dout:for l in 0 to 7 loop
					if hitCheck(l) = '1' then
						case addressFront(4 downto 2) is
							when "000" => dataFront <= DATACACHE(l)(255 downto 224);
							
							when "001" => dataFront <= DATACACHE(l)(223 downto 192);
							
							when "010" => dataFront <= DATACACHE(l)(191 downto 160);
							
							when "011" => dataFront <= DATACACHE(l)(159 downto 128);
							
							when "100" => dataFront <= DATACACHE(l)(127 downto 96);
							
							when "101" => dataFront <= DATACACHE(l)(95 downto 64);
							
							when "110" => dataFront <= DATACACHE(l)(63 downto 32);
							
							when "111" => dataFront <= DATACACHE(l)(31 downto 0);
						
							when others => dataFront <= (others => 'Z');
						end case;
					exit dout;
					end if;
				end loop dout;
				
			end if;
		else
			dataFront <= (others=>'Z');
		end if;
	end process;
	
	addressBack <= addressFront(31 downto 5) & wordID(2 downto 0) & "00";
	
	--update <= '1' when wordID = "1000" else '0';
	
	
	process(hitMem, preMISS)
	begin
		if ce_n = '0' then
			if hitMem'event and hitMem = '1' then
				if preMISS = '1' then
					wordBuffer(256) <= '1';
					case wordID is
						when "0000" => wordBuffer(255 downto 224) <= dataBack;  wordID <= "0001"; 
						when "0001" => wordBuffer(223 downto 192) <= dataBack;  wordID <= "0010";
						when "0010" => wordBuffer(191 downto 160) <= dataBack;  wordID <= "0011";
						when "0011" => wordBuffer(159 downto 128) <= dataBack;  wordID <= "0100";
						when "0100" => wordBuffer(127 downto 96)  <= dataBack;  wordID <= "0101";
						when "0101" => wordBuffer(95 downto 64)   <= dataBack;  wordID <= "0110";
						when "0110" => wordBuffer(63 downto 32)   <= dataBack;  wordID <= "0111";
						when "0111" => wordBuffer(31 downto 0)    <= dataBack;  wordID <= "1000";
						when "1000" => wordID <= "0000"; update <= '1';
						when others => NULL;
					end case;
				end if;
			elsif preMISS = '0' then
				update <= '0';
			end if;
		end if;
	end process;
	 

   

end Cache_L2;

-------------------------------------------------------------------------
--  CPU PROCESSOR SIMULATION TESTBENCH
-------------------------------------------------------------------------
library ieee;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;          
use STD.TEXTIO.all;
use work.aux_functions.all;

entity CPU_tb is
end CPU_tb;

architecture cpu_tb of cpu_tb is
    
    signal Dadress, Ddata, Iadress, memAdd, L2Add, Idata, L2data,
           i_cpu_address, d_cpu_address, data_cpu, tb_add, tb_data : reg32 := (others => '0' );
    
    signal Dce_n, Dwe_n, Doe_n, Ice_n, Iwe_n, Ioe_n, ck, rst, rstCPU, hold, 
           go_i, go_d, ce, rw, bw, ck_Mem, ck_L2, ce_l2, hitMem, hitL2, missL2: std_logic;
    
    file ARQ : TEXT open READ_MODE is "PCSpim.log";
 
begin
           
    Data_mem:  entity work.RAM_mem_Data
               generic map( START_ADDRESS => x"10010000" )
               port map (ce_n=>Dce_n, we_n=>Dwe_n, oe_n=>Doe_n, bw=>bw, address=>Dadress, data=>Ddata);
                                            
    Instr_mem: entity work.RAM_mem_Instr
               generic map( START_ADDRESS => x"00400020" )
               port map (ce_n=>Ice_n, we_n=>Iwe_n, oe_n=>Ioe_n, hit=>hitMem, bw=>'1', ck=>ck_Mem, address=>Iadress, data=>Idata);
					
	CacheL2: entity work.Cache_L2
               port map (ce_n=>ce_L2, ck=>ck_L2, hitMem=>hitMem, hit=>hitL2, miss=>missL2, addressBack=>memAdd, addressFront=>L2Add, dataFront=>L2Data, dataBack=>Idata);
		  
	 ce_L2 <= '0' when rstCPU = '0' else '1';
    hold <= '0';                                 

    -- data memory signals --------------------------------------------------------
    Dce_n <= '0' when  ce='1' or go_d='1'             else '1';
    Doe_n <= '0' when (ce='1' and rw='1')             else '1';       
    Dwe_n <= '0' when (ce='1' and rw='0') or go_d='1' else '1';    

    Dadress <= tb_add  when rstCPU='1' else d_cpu_address;
    Ddata   <= tb_data when rstCPU='1' else data_cpu when (ce='1' and rw='0') else (others=>'Z'); 
    
    data_cpu <= Ddata when (ce='1' and rw='1') else (others=>'Z');
    
    -- instructions memory signals --------------------------------------------------------
    Ice_n <= '0' when rstCPU='1' else not(missL2);                                 
    Ioe_n <= '1' when rstCPU='1' else '0';           -- impede leitura enquanto est� escrevendo                             
    Iwe_n <= '0' when go_i='1'   else '1';           -- escrita durante a leitura do arquivo 
    
    Iadress <= tb_add  when rstCPU='1' else memAdd;
    Idata   <= tb_data when rstCPU='1' else (others => 'Z'); 
  

    cpu: entity work.MRstd  port map(
              clock=>ck, ck_Mem=>hitL2, reset=>rstCPU,	hold=>hold,
              i_address => L2Add,
              instruction => L2Data,
              ce=>ce,  rw=>rw,  bw=>bw,
              d_address => d_cpu_address,
              data => data_cpu
        ); 

    rst <='1', '0' after 25 ns;       -- generates the reset signal 

    process                          -- generates the clock signal 
        begin
        ck <= '1', '0' after 10 ns;
        wait for 20 ns;
    end process;
	 
	  process                          -- generates the clock signal for memory 
		begin
			ck_Mem <= '1', '0' after 40 ns;
			wait for 80 ns;
    end process;
	 
	 process                          -- generates the clock signal for cache L2
		begin
			ck_L2 <= '1', '0' after 20 ns;
			wait for 40 ns;
    end process;

    
    ----------------------------------------------------------------------------
    -- this process loads the instruction memory and the data memory during reset
    --
    --
    --   O PROCESSO ABAIXO � UMA PARSER PARA LER C�DIGO GERADO PELO SPIM NO
    --   SEGUINTE FORMATO:
    --
    --      .CODE
    --      [0x00400020]        0x3c011001  lui $1, 4097 [d2]               ; 16: la    $t0, d2
    --      [0x00400024]        0x34280004  ori $8, $1, 4 [d2]
    --      [0x00400028]        0x8d080000  lw $8, 0($8)                    ; 17: lw    $t0,0($t0)
    --      .....
    --      [0x00400048]        0x0810000f  j 0x0040003c [loop]             ; 30: j     loop
    --      [0x0040004c]        0x01284821  addu $9, $9, $8                 ; 32: addu $t1, $t1, $t0
    --      [0x00400050]        0x08100014  j 0x00400050 [x]                ; 34: j     x
    --      .DATA
    --      [0x10010000]                        0x0000faaa  0x00000083  0x00000000  0x00000000
    --
    ----------------------------------------------------------------------------
    process
        variable ARQ_LINE : LINE;
        variable line_arq : string(1 to 200);
        variable code     : boolean;
        variable i, address_flag : integer;
    begin  
        go_i <= '0';
        go_d <= '0';
        rstCPU <= '1';           -- hold the processor during file reading
        code:=true;              -- default value of code is 1 (CODE)
                                 
        wait until rst = '1';
        
        while NOT (endfile(ARQ)) loop    -- IN�CIO DA LEITURA DO ARQUIVO CONTENDO INSTRU��O E DADOS -----
            readline(ARQ, ARQ_LINE);      
            read(ARQ_LINE, line_arq(1 to  ARQ_LINE'length) );
                        
            if line_arq(1 to 5)=".CODE" then 
                   code:=true;                     -- code 
            elsif line_arq(1 to 5)=".DATA" then
                   code:=false;                    -- data 
            else 
               i := 1;                                  -- LEITORA DE LINHA - analizar o loop abaixo para compreender 
               address_flag := 0;                       -- para INSTRU��O � um para (end,inst)
                                                        -- para DADO aceita (end, dado 0, dado 1, dado 2 ....)
               loop                                     
                  if line_arq(i) = '0' and line_arq(i+1) = 'x' then      -- encontrou indica��o de n�mero hexa: '0x'
                         i := i + 2;
                         if address_flag=0 then
                               for w in 0 to 7 loop
                                   tb_add( (31-w*4) downto (32-(w+1)*4))  <= CONV_VECTOR(line_arq,i+w);
                               end loop;    
                               i := i + 8; 
                               address_flag := 1;
                         else
                               for w in 0 to 7 loop
                                   tb_data( (31-w*4) downto (32-(w+1)*4))  <= CONV_VECTOR(line_arq,i+w);
                               end loop;    
                               i := i + 8;
                               
                               wait for 0.1 ns;
                               
                               if code=true then go_i <= '1';    -- the go_i signal enables instruction memory writing
                                            else go_d <= '1';    -- the go_d signal enables data memory writing
                               end if; 
                               
                               wait for 0.1 ns;
                               
                               tb_add <= tb_add + 4;       -- *great!* consigo ler mais de uma word por linha!
                               go_i <= '0';
                               go_d <= '0'; 
                               
                               address_flag := 2;    -- sinaliza que j� leu o conte�do do endere�o;

                         end if;
                  end if;
                  i := i + 1;
                  
                  -- sai da linha quando chegou no seu final OU j� leu par(endere�o, instru��o) no caso de c�digo
                  exit when i=TAM_LINHA or (code=true and address_flag=2);
               end loop;
            end if;
            
        end loop;                        -- FINAL DA LEITURA DO ARQUIVO CONTENDO INSTRU��O E DADOS -----
        
        rstCPU <= '0';   -- release the processor to execute
        wait for 2 ns;   -- To activate the RST CPU signal
        wait until rst = '1';  -- to Hold again!
        
    end process;
    
end cpu_tb;
