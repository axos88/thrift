require 'spec_helper'

shared_examples_for 'a memory buffer' do
  before(:each) do
    @trans = transport_class.new
    @buf = " " * (512 * (2**10));
  end

  it 'should write one byte correctly' do
  	@trans.write("a");

  	(@trans.available).should eq 1
  end

  it 'should write multiple byte correctly' do
  	@trans.write("abcdefghijklmnopqrst");

  	(@trans.available).should eq 20
  end

  it 'should write a combination of bytes correctly' do
  	@trans.write("a");
  	@trans.write("bc");
  	@trans.write("def");
  	@trans.write("g");
  	@trans.write("hijk");
  	@trans.write("l");
  	@trans.write("m");
  	@trans.write("n");
  	@trans.write("opqr");
  	@trans.write("st");

  	(@trans.available).should eq 20
 end


 it 'should raise an exception if there are no bytes to read' do
 	expect{@trans.read(1)}.to raise_error(EOFError)
 	expect{@trans.read_byte()}.to raise_error(EOFError)
 	expect{@trans.read_into_buffer(@buf, 1)}.to raise_error(EOFError)
 end

 it 'should have the read_byte funciton working correctly' do

 	str = "The red fox jumps over the lazy brown dog";

 	@trans.write(str);

 	str.each_char do |c|
 		(@trans.read_byte).should eq c.ord
 	end

 end

 it 'should return the written bytes correctly' do
 	tests = [ "a", "abcd", "abcdefghijklm", "aiuhdeury7843yiru3r4"]

 	tests.each do |t|
 		@trans.write(t);

 		read = @trans.read_all(@trans.available);

 		(read).should eq t;
 	end
 end

 it 'should return written bytes read in chunks correctly' do
 	tests = [ "a", "abcd", "abcdefghijklm", "aiuhdeury7843yiru3r4", "reiuhgirtuehruw9ehfi23hwfipuheirhriuoehfoudbe3giupr3hwesipuhipruenrpiuhfipeuwhfpiurwhgipuewhfiuerhrfuohoihqwriotuh3ew8ufherioufhrouhouoiuhofre'"];

 	tests.each do |t|
 		@trans.write(t);



 		i = 0;
 		while i<t.length do
 			( t.length - i ).should eq @trans.available

 			r = [16, @trans.available].min;
 			read = @trans.read(r);

 			(read).should eq t[i,r];

 			i = i + r;
 		end

 		(@trans.available).should eq 0

 	end
 end

 it 'should respond correctly to resetting the buffer' do

  str = "The red fox jumps over the lazy brown dog";

  @trans.reset_buffer(str);
  (@trans.read(@trans.available)).should eq str

  @trans.reset_buffer(str);
  (@trans.read(@trans.available)).should eq str

  @trans.write("AABBCCDD");
  @trans.reset_buffer(str);
  (@trans.read(@trans.available)).should eq str

  @trans.write("AABBCCDD");
  @trans.reset_buffer(str);
  @trans.reset_buffer(str);
  (@trans.read(@trans.available)).should eq str
end

it 'should respond correctly to resetting the buffer without an argument' do

  @trans.reset_buffer;
  (@trans.available).should eq 0

  @trans.reset_buffer;
  (@trans.available).should eq 0

  @trans.write("AABBCCDD");
  @trans.reset_buffer;
  (@trans.available).should eq 0
end

it 'should return the correct number of bytes when read_into_buffer is called' do

  str = "The red fox jumps over the lazy brown dog";

  @trans.reset_buffer(str);

  @buf = ""

  expect{@trans.read_into_buffer(@buf, 2)}.to raise_error(StandardError)

  @buf = " " * 200;

  (@trans.read_into_buffer(@buf, 2)).should eq 2
  (@trans.read_into_buffer(@buf, 7)).should eq 7
  (@trans.read_into_buffer(@buf, 4)).should eq 4
end


end
