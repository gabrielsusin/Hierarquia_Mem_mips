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
	subtype reg2	is std_logic_vector(1 downto 0);
   -- definio do tipo 'memory', que ser utilizado para as memrias de dados/instrues
   constant MEMORY_SIZE : integer := 2048;     
   type memory is array (0 to MEMORY_SIZE) of reg8;
	
	constant L1_LINHA : integer := 3;
	
	type CACHE_L1 is array (0 to L1_LINHA) of std_logic_vector(154 downto 0) ;

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
library IEEE;
use ieee.std_logic_1164.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use work.aux_functions.all;

entity RAM_mem_Instr is
      generic(  START_ADDRESS: reg32 := (others=>'0')  );
      port( ce_n, we_n, oe_n, bw, ck: in std_logic;   address: in reg32;   data: inout reg32; MISS: in std_logic);
end RAM_mem_Instr;

architecture RAM_mem_Instr of RAM_mem_Instr is
   signal RAM : memory;
   signal tmp_address: reg32;
	signal f_hold: std_logic;
   alias  low_address: reg16 is tmp_address(15 downto 0);    --  baixa para 16 bits devido ao CONV_INTEGER --
begin     

   tmp_address <= address - START_ADDRESS;   --  offset do endereçamento  -- 
	
   
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
   process(ce_n, oe_n, low_address, ck, MISS)
     begin
       if ce_n='0' and oe_n='0' and MISS = '1' and
          CONV_INTEGER(low_address)>=0 and CONV_INTEGER(low_address+3)<=MEMORY_SIZE then
			if ck'event and ck = '1' then
            data(31 downto 24) <= RAM(CONV_INTEGER(low_address+3));
            data(23 downto 16) <= RAM(CONV_INTEGER(low_address+2));
            data(15 downto  8) <= RAM(CONV_INTEGER(low_address+1));
            data( 7 downto  0) <= RAM(CONV_INTEGER(low_address  ));
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
-- Module implementing a behavioral model of an ASYNCHRONOUS INTERFACE DATA RAM 
--------------------------------------------------------------------------
library IEEE;
use ieee.std_logic_1164.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use work.aux_functions.all;

entity RAM_mem_Data is
      generic(  START_ADDRESS: reg32 := (others=>'0') );
      port( ce_n, we_n, oe_n, bw: in std_logic;    address: in reg32;   data: inout reg32);
end RAM_mem_Data;

architecture RAM_mem_Data of RAM_mem_Data is 
   signal RAM : memory;
   signal tmp_address: reg32;
   alias  low_address: reg16 is tmp_address(15 downto 0);    --  baixa para 16 bits devido ao CONV_INTEGER --
begin     

   tmp_address <= address - START_ADDRESS;   --  offset do endereamento  -- 
   
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
-------------------------------------------------------------------------
-- L1 CACHE 
-------------------------------------------------------------------------
-- dado que vem da memoria em caso de miss possui qual tamanho 128 ou 32
--sinais de controle
--preenchiento da L1 ao inicialiar, como se da

library IEEE;
use ieee.std_logic_1164.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use work.aux_functions.all;

entity L1 is
	port(ck,ckMEM: in std_logic;dataCPU: out reg32;dataMEM: in reg32; 
	address: in reg32; addressOUT: out reg32;  oe_n: in std_logic; 
	L1_hit,L1_miss : out std_logic );
end L1;

architecture L1 of L1 is
	type estados is (a,b,c,d,e,f);
	signal estado: estados;
	signal Linha: std_logic_vector(154 downto 0) := (others => '0');
	signal L1: CACHE_L1 := (others=> Linha);
	--signal tmp_address: reg32;
	signal word: std_logic_vector (1 downto 0) := (others => '0');
	alias  linhaReg: reg2 is address(5 downto 4);
	signal linhaMEM: std_logic_vector (127 downto 0) := (others => 'Z');
	signal pronto, L1hit,L1miss: std_logic := '0';
begin
  
L1hit <= '1' when Linha(154) = '1' and Linha(153 downto 128) = address(31 downto 6)
 and ck = '1' else '0';
L1miss <= '1' when (Linha(154) /= '1' or Linha(153 downto 128) /= address(31 downto 6)) 
and oe_n = '0' else  '0';
Linha <= L1(CONV_INTEGER(linhaReg));
L1_hit <= L1hit;
L1_miss<= L1miss;

  process(address,L1hit,oe_n,ck)
    begin
	 if oe_n='0' then
		if L1hit = '1' then 
				case address(3 downto 2) is
					when  "00" => dataCPU(31 downto 0) <= Linha(127 downto 96);
					when  "01" => dataCPU(31 downto 0) <= Linha(95 downto 64);
					when  "10" => dataCPU(31 downto 0) <= Linha(63 downto 32);
					when  "11" => dataCPU(31 downto 0) <= Linha(31 downto 0);
					when others => dataCPU(31 downto 0) <= (others=> 'Z');
				end case;
		 end if;
		elsif oe_n = '1' then 
			dataCPU(31 downto 0) <= (others=> 'Z');
			addressOUT(31 downto 0) <= (others => 'Z');
		--	L1(0)<=(others=> '0');
		--	L1(1)<=(others=> '0');
		--	L1(2)<=(others=> '0');
		--	L1(3)<=(others=> '0');
	 end if;
    end process; 
	 
	 addressOUT <= address(31 downto 4) & word & "00";
	 
	  process(ckMEM,L1Miss,estado)
	 --variable contador: integer range 4 downto 0 := 0;
	 begin
		if L1Miss = '1' then
			if ckMEM'event and ckMEM = '1' then 
				case estado is 
					when a=> word <= "00";estado<= b;
					when b=> word <= "01";estado<= c;
					when c=> linhaMEM(127 downto 96) <= dataMEM;word <= "10"; estado<= d;
					when d=> linhaMEM(95 downto 64) <= dataMEM;word <= "11";estado<= e;
					when e=> linhaMEM(63 downto 32) <= dataMEM; word <= "00";estado<= f;
					when f=> linhaMEM(31 downto 0) <= dataMEM;pronto <= '1';estado<= a;
				end case;
			 elsif ckMEM'event and ckMEM = '0' then
					if pronto = '1' then 
						L1(CONV_INTEGER(linhaReg))<= '1' & address(31 downto 6) & linhaMEM;
					end if;
			end if;
		else pronto <= '0';
		word <= "00";
	--	estado <= a;
		end if;
	 end process;
	 
end L1;
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
    
    signal Dadress, Ddata, Iadress, Idata, L1_MEMaddress, addressL1,L1_MEMdata,
           i_cpu_address, d_cpu_address, data_cpu, tb_add, tb_data : reg32 := (others => '0' );
    
    signal Dce_n, Dwe_n, Doe_n, Ice_n, Iwe_n, Ioe_n, ck, rst, rstCPU, hold, 
           go_i, go_d, ce, rw, bw, ck_Mem_Instr, L1_Hit,L1_Miss: std_logic;
    
    file ARQ : TEXT open READ_MODE is "PCSpim.log";
 
begin
           
    Data_mem:  entity work.RAM_mem_Data 
               generic map( START_ADDRESS => x"10010000" )
               port map (ce_n=>Dce_n, we_n=>Dwe_n, oe_n=>Doe_n, bw=>bw, address=>Dadress, data=>Ddata);
                                            
    Instr_mem: entity work.RAM_mem_Instr
               generic map( START_ADDRESS => x"00400020" )
               port map (ce_n=>Ice_n, we_n=>Iwe_n, oe_n=>Ioe_n, bw=>'1',ck=>ck_Mem_Instr, address=>L1_MEMaddress, data=>L1_MEMdata,
					MISS=>L1_Miss);
        
	 Cache_L1: entity work.L1
					port map (dataCPU=>Idata,dataMEM=>L1_MEMdata, address=>Iadress, addressOUT=>addressL1,  oe_n=>Ioe_n, 
					L1_hit=>L1_Hit,L1_miss => L1_Miss, ck=> ck, ckMEM=> ck_Mem_Instr);
    hold <= '0';                                 

    -- data memory signals --------------------------------------------------------
    Dce_n <= '0' when  ce='1' or go_d='1'             else '1';
    Doe_n <= '0' when (ce='1' and rw='1')             else '1';       
    Dwe_n <= '0' when (ce='1' and rw='0') or go_d='1' else '1';    

    Dadress <= tb_add  when rstCPU='1' else d_cpu_address;
    Ddata   <= tb_data when rstCPU='1' else data_cpu when (ce='1' and rw='0') else (others=>'Z'); 
    
    data_cpu <= Ddata when (ce='1' and rw='1') else (others=>'Z');
    
    -- instructions memory signals --------------------------------------------------------
    Ice_n <=  '0' when rstCPU = '1'  or L1_miss= '1' else '1';                                 
    Ioe_n <= '1' when rstCPU='1' else '0';           -- impede leitura enquanto est escrevendo                             
    Iwe_n <= '0' when go_i='1'   else '1';           -- escrita durante a leitura do arquivo 
    
    Iadress <= tb_add  when rstCPU='1' else i_cpu_address;
    L1_MEMdata   <= tb_data when rstCPU='1' else (others => 'Z'); 
	 L1_MEMaddress <= Iadress when rstCPU = '1' else addressL1; 
	 
    cpu: entity work.MRstd  port map(
              clock=>ck, reset=>rstCPU,	hold=>hold,
              i_address => i_cpu_address,
              instruction => Idata,
              ce=>ce,  rw=>rw,  bw=>bw,
              d_address => d_cpu_address,
              data => data_cpu,
				  L1_hit=>L1_Hit
        ); 

    rst <='1', '0' after 25 ns;       -- generates the reset signal 

    process                          -- generates the clock signal 
        begin
        ck <= '1', '0' after 10 ns;
        wait for 20 ns;
    end process;
	 
	process                          -- generates the clock signal 
        begin
        ck_Mem_Instr <= '1', '0' after 40 ns;
        wait for 80 ns;
    end process;
	 

	
    
    ----------------------------------------------------------------------------
    -- this process loads the instruction memory and the data memory during reset
    --
    --
    --   O PROCESSO ABAIXO  UMA PARSER PARA LER CDIGO GERADO PELO SPIM NO
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
        
        while NOT (endfile(ARQ)) loop    -- INCIO DA LEITURA DO ARQUIVO CONTENDO INSTRUO E DADOS -----
            readline(ARQ, ARQ_LINE);      
            read(ARQ_LINE, line_arq(1 to  ARQ_LINE'length) );
                        
            if line_arq(1 to 5)=".TEXT" then 
                   code:=true;                     -- code 
            elsif line_arq(1 to 5)=".DATA" then
                   code:=false;                    -- data 
            else 
               i := 1;                                  -- LEITORA DE LINHA - analizar o loop abaixo para compreender 
               address_flag := 0;                       -- para INSTRUO  um para (end,inst)
                                                        -- para DADO aceita (end, dado 0, dado 1, dado 2 ....)
               loop                                     
                  if line_arq(i) = '0' and line_arq(i+1) = 'x' then      -- encontrou indicao de nmero hexa: '0x'
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
                               
                               address_flag := 2;    -- sinaliza que j leu o contedo do endereo;

                         end if;
                  end if;
                  i := i + 1;
                  
                  -- sai da linha quando chegou no seu final OU j leu par(endereo, instruo) no caso de cdigo
                  exit when i=TAM_LINHA or (code=true and address_flag=2);
               end loop;
            end if;
            
        end loop;                        -- FINAL DA LEITURA DO ARQUIVO CONTENDO INSTRUO E DADOS -----
        
        rstCPU <= '0';   -- release the processor to execute
        wait for 2 ns;   -- To activate the RST CPU signal
        wait until rst = '1';  -- to Hold again!
        
    end process;
    
end cpu_tb;
