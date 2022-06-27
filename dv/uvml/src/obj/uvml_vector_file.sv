// Copyright 2021 Datum Technology Corporation
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`ifndef __UVML_VECTOR_FILE_SV__
`define __UVML_VECTOR_FILE_SV__


/**
 * Object which reads text from files and prepares it for consumption by uvm_packer for deserializing objects from disk.
 * @warning It is not recommended to combine calls to get_next_line() and get_next_block()
 */
class uvml_vector_file_c extends uvml_file_c;

   uvm_pack_bitstream_t  data     ;
   int unsigned          bits_used;


   `uvm_object_utils(uvml_vector_file_c)


   /**
    * Default constructor.
    */
   extern function new(string name="uvml_vector_file");

   /**
    * TODO Describe uvml_vector_file_c::get_next_line_bits()
    */
   extern function void get_next_line_bits(uvm_radix_enum radix, output uvml_bit_array_t bits);

   /**
    * TODO Describe uvml_vector_file_c::get_next_line_bytes()
    */
   extern function void get_next_line_bytes(uvm_radix_enum radix, output uvml_byte_array_t bytes);

   /**
    * TODO Describe uvml_vector_file_c::get_next_line_ints()
    */
   extern function void get_next_line_ints(uvm_radix_enum radix, output uvml_int_array_t ints);

   /**
    * TODO Describe uvml_vector_file_c::get_next_lines_bits()
    */
   extern function void get_next_lines_bits(int unsigned num_lines, uvm_radix_enum radix, output uvml_bit_array_t bits);

   /**
    * TODO Describe uvml_vector_file_c::get_next_lines_bytes()
    */
   extern function void get_next_lines_bytes(int unsigned num_lines, uvm_radix_enum radix, output uvml_byte_array_t bytes);

   /**
    * TODO Describe uvml_vector_file_c::get_next_lines_ints()
    */
   extern function void get_next_lines_ints(int unsigned num_lines, uvm_radix_enum radix, output uvml_int_array_t ints);

   /**
    * TODO Describe uvml_vector_file_c::get_next_block_bits()
    */
   extern function void get_next_block_bits(int unsigned num_bits, uvm_radix_enum radix, output uvml_bit_array_t bits);

   /**
    * TODO Describe uvml_vector_file_c::get_next_block_bytes()
    */
   extern function void get_next_block_bytes(int unsigned num_bytes, uvm_radix_enum radix, output uvml_byte_array_t bytes);

   /**
    * TODO Describe uvml_vector_file_c::get_next_block_ints()
    */
   extern function void get_next_block_ints(int unsigned num_ints, uvm_radix_enum radix, output uvml_int_array_t ints);

   /**
    * TODO Describe uvml_vector_file_c::pack_data()
    */
   extern function void pack_data(string text, uvm_radix_enum radix, bit reverse_nibble=0);

   /**
    * TODO Describe uvml_vector_file_c::reset()
    */
   extern function void reset();

   /**
    * TODO Describe uvml_vector_file_c::reverse_str()
    */
   extern function string reverse_str(string text);

endclass : uvml_vector_file_c


function uvml_vector_file_c::new(string name="uvml_vector_file");

   super.new(name);

endfunction : new


function void uvml_vector_file_c::get_next_line_bits(uvm_radix_enum radix, output uvml_bit_array_t bits);

   get_next_lines_bits(1, radix, bits);

endfunction : get_next_line_bits


function void uvml_vector_file_c::get_next_line_bytes(uvm_radix_enum radix, output uvml_byte_array_t bytes);

   get_next_lines_bytes(1, radix, bytes);

endfunction : get_next_line_bytes


function void uvml_vector_file_c::get_next_line_ints(uvm_radix_enum radix, output uvml_int_array_t ints);

   get_next_lines_ints(1, radix, ints);

endfunction : get_next_line_ints


function void uvml_vector_file_c::get_next_lines_bits(int unsigned num_lines, uvm_radix_enum radix, output uvml_bit_array_t bits);

   string  data_text = "";
   string  line;

   reset();
   repeat (num_lines) begin
      line = read_line();
      if (is_eof()) begin
         line = line.substr(0, line.len()-1);
      end
      else begin
         line = line.substr(0, line.len()-2);
      end
      //line = reverse_str(line);
      data_text = {line, data_text};
   end
   pack_data(data_text, radix, 0);
   bits = new[bits_used];
   foreach (bits[ii]) begin
      bits[ii] = data[ii];
   end

endfunction : get_next_lines_bits


function void uvml_vector_file_c::get_next_lines_bytes(int unsigned num_lines, uvm_radix_enum radix, output uvml_byte_array_t bytes);

   string  data_text = "";
   string  line;
   byte    byte_array[];

   reset();
   repeat (num_lines) begin
      line = read_line();
      if (is_eof()) begin
         line = line.substr(0, line.len()-1);
      end
      else begin
         line = line.substr(0, line.len()-2);
      end
      line = reverse_str(line);
      data_text = {line, data_text};
   end
   pack_data(data_text, radix);
   byte_array = new[bits_used/8];
   foreach (byte_array[ii]) begin
      byte_array[ii][0] = data[ii*8+4];
      byte_array[ii][1] = data[ii*8+5];
      byte_array[ii][2] = data[ii*8+6];
      byte_array[ii][3] = data[ii*8+7];
      byte_array[ii][4] = data[ii*8+0];
      byte_array[ii][5] = data[ii*8+1];
      byte_array[ii][6] = data[ii*8+2];
      byte_array[ii][7] = data[ii*8+3];
   end

   bytes = new[byte_array.size()];
   foreach (bytes[ii]) begin
      bytes[ii] = byte_array[ii];
   end

endfunction : get_next_lines_bytes


function void uvml_vector_file_c::get_next_lines_ints(int unsigned num_lines, uvm_radix_enum radix, output uvml_int_array_t ints);

   //string  data_text = "";
   //string  line;
   //
   //reset();
   //repeat (num_lines) begin
   //   line = read_line();
   //   line = line.substr(0, line.len()-2);
   //   line = reverse_str(line);
   //   data_text = {line, data_text};
   //end
   //pack_data(data_text, radix);
   //// TODO Implement uvml_vector_file_c::get_next_lines_ints()
   //
   //`uvm_info("VECTOR_FILE", $sformatf("Final int count is %0d", get_next_lines_ints.size()), UVM_NONE/*UVM_DEBUG*/)

endfunction : get_next_lines_ints


function void uvml_vector_file_c::get_next_block_bits(int unsigned num_bits, uvm_radix_enum radix, output uvml_bit_array_t bits);

   //reset();
   //while (bits_used < num_bits) begin
   //   pack_data(read_line(), radix);
   //end
   //
   //get_next_block_bits = new[num_bits];
   //// TODO Implement uvml_vector_file_c::get_next_block_bits()

endfunction : get_next_block_bits


function void uvml_vector_file_c::get_next_block_bytes(int unsigned num_bytes, uvm_radix_enum radix, output uvml_byte_array_t bytes);

   //reset();
   //while (bits_used < (num_bytes*8)) begin
   //   pack_data(read_line(), radix);
   //end
   //
   //get_next_block_bytes = new[num_bytes];
   //// TODO Implement uvml_vector_file_c::get_next_block_bytes()

endfunction : get_next_block_bytes


function void uvml_vector_file_c::get_next_block_ints(int unsigned num_ints, uvm_radix_enum radix, output uvml_int_array_t ints);

   //reset();
   //while (bits_used < (num_ints*32)) begin
   //   pack_data(read_line(), radix);
   //end
   //
   //get_next_block_ints = new[num_ints];
   //// TODO Implement uvml_vector_file_c::get_next_block_ints()

endfunction : get_next_block_ints


function void uvml_vector_file_c::pack_data(string text, uvm_radix_enum radix, bit reverse_nibble=0);

   int           scan;
   string        char;
   int unsigned  text_len = text.len();
   bit           bin_val;
   bit [02:00]   oct_val;
   bit [03:00]   hex_val;
   int           dec_val;

   `uvm_info("VECTOR_FILE", $sformatf("Input text to pack_data() is '%s'", text), UVM_DEBUG)

   case (radix)
      UVM_BIN: begin
         for (int ii=(text_len-1); ii>=0; ii--) begin
            char = text.substr(ii, ii);
            scan = $sscanf(char, "%b", bin_val);
            if (scan) begin
               data[bits_used++] = bin_val;
            end
         end
      end

      UVM_DEC: begin
         for (int ii=(text_len-1); ii>=0; ii--) begin
            char = text.substr(ii, ii);
            scan = $sscanf(char, "%d", dec_val);
            if (scan) begin
               data[bits_used++] = dec_val[00];
               data[bits_used++] = dec_val[01];
               data[bits_used++] = dec_val[02];
               data[bits_used++] = dec_val[03];
               data[bits_used++] = dec_val[04];
               data[bits_used++] = dec_val[05];
               data[bits_used++] = dec_val[06];
               data[bits_used++] = dec_val[07];
               data[bits_used++] = dec_val[08];
               data[bits_used++] = dec_val[09];
               data[bits_used++] = dec_val[10];
               data[bits_used++] = dec_val[11];
               data[bits_used++] = dec_val[12];
               data[bits_used++] = dec_val[13];
               data[bits_used++] = dec_val[14];
               data[bits_used++] = dec_val[15];
               data[bits_used++] = dec_val[16];
               data[bits_used++] = dec_val[17];
               data[bits_used++] = dec_val[18];
               data[bits_used++] = dec_val[19];
               data[bits_used++] = dec_val[20];
               data[bits_used++] = dec_val[21];
               data[bits_used++] = dec_val[22];
               data[bits_used++] = dec_val[23];
               data[bits_used++] = dec_val[24];
               data[bits_used++] = dec_val[25];
               data[bits_used++] = dec_val[26];
               data[bits_used++] = dec_val[27];
               data[bits_used++] = dec_val[28];
               data[bits_used++] = dec_val[29];
               data[bits_used++] = dec_val[30];
               data[bits_used++] = dec_val[31];
            end
         end
      end

      UVM_UNSIGNED: begin
         for (int ii=(text_len-1); ii>=0; ii--) begin
            char = text.substr(ii, ii);
            scan = $sscanf(char, "%u", dec_val);
            if (scan) begin
               data[bits_used++] = dec_val[00];
               data[bits_used++] = dec_val[01];
               data[bits_used++] = dec_val[02];
               data[bits_used++] = dec_val[03];
               data[bits_used++] = dec_val[04];
               data[bits_used++] = dec_val[05];
               data[bits_used++] = dec_val[06];
               data[bits_used++] = dec_val[07];
               data[bits_used++] = dec_val[08];
               data[bits_used++] = dec_val[09];
               data[bits_used++] = dec_val[10];
               data[bits_used++] = dec_val[11];
               data[bits_used++] = dec_val[12];
               data[bits_used++] = dec_val[13];
               data[bits_used++] = dec_val[14];
               data[bits_used++] = dec_val[15];
               data[bits_used++] = dec_val[16];
               data[bits_used++] = dec_val[17];
               data[bits_used++] = dec_val[18];
               data[bits_used++] = dec_val[19];
               data[bits_used++] = dec_val[20];
               data[bits_used++] = dec_val[21];
               data[bits_used++] = dec_val[22];
               data[bits_used++] = dec_val[23];
               data[bits_used++] = dec_val[24];
               data[bits_used++] = dec_val[25];
               data[bits_used++] = dec_val[26];
               data[bits_used++] = dec_val[27];
               data[bits_used++] = dec_val[28];
               data[bits_used++] = dec_val[29];
               data[bits_used++] = dec_val[30];
               data[bits_used++] = dec_val[31];
            end
         end
      end

      UVM_OCT: begin
         for (int ii=(text_len-1); ii>=0; ii--) begin
            char = text.substr(ii, ii);
            scan = $sscanf(char, "%o", oct_val);
            if (scan) begin
               data[bits_used++] = oct_val[0];
               data[bits_used++] = oct_val[1];
               data[bits_used++] = oct_val[2];
            end
         end
      end

      UVM_HEX: begin
         for (int ii=(text_len-1); ii>=0; ii--) begin
            char = text.substr(ii, ii);
            scan = $sscanf(char, "%h", hex_val);
            if (scan) begin
               if (reverse_nibble) begin
                  data[bits_used++] = hex_val[3];
                  data[bits_used++] = hex_val[2];
                  data[bits_used++] = hex_val[1];
                  data[bits_used++] = hex_val[0];
               end
               else begin
                  data[bits_used++] = hex_val[0];
                  data[bits_used++] = hex_val[1];
                  data[bits_used++] = hex_val[2];
                  data[bits_used++] = hex_val[3];
               end
            end
         end
      end

      default: begin
         `uvm_fatal("VECTOR_FILE", $sformatf("Invalid radix (%s)", radix.name()))
      end
   endcase

   `uvm_info("VECTOR_FILE", $sformatf("data after packing: %h", data), UVM_DEBUG)

endfunction : pack_data


function void uvml_vector_file_c::reset();

   data      = 0;
   bits_used = 0;

endfunction : reset


function string uvml_vector_file_c::reverse_str(string text);

   reverse_str = "";

   for (int ii=(text.len()-1); ii>=0; ii--) begin
      reverse_str = {reverse_str, text.substr(ii,ii)};
   end

endfunction : reverse_str


`endif // __UVML_VECTOR_FILE_SV__
