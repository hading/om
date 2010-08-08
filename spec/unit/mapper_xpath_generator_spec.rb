require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require "om"

describe "OM::XML::MapperXpathGeneratorSpec" do

  before(:each) do
    @test_mapper = OM::XML::Mapper.new(:terms_of_address, :path=>"namePart", :attributes=>{:type=>"termsOfAddress"})
    @test_mapper_with_default_path = OM::XML::Mapper.new(:volume, :path=>"detail", :attributes=>{:type=>"volume"}, :default_content_path=>"number")
  end
  
  describe "generate_xpath" do
    it "should generate an xpath based on the given mapper and options" do
      OM::XML::MapperXpathGenerator.expects(:generate_absolute_xpath).with(@test_mapper)
      OM::XML::MapperXpathGenerator.generate_xpath(@test_mapper, :absolute)
      
      OM::XML::MapperXpathGenerator.expects(:generate_relative_xpath).with(@test_mapper)
      OM::XML::MapperXpathGenerator.generate_xpath(@test_mapper, :relative)
      
      OM::XML::MapperXpathGenerator.expects(:generate_constrained_xpath).with(@test_mapper)
      OM::XML::MapperXpathGenerator.generate_xpath(@test_mapper, :constrained)
    end
  end
    
  describe "generate_relative_xpath" do
    it "should generate a relative xpath based on the given mapper" do
      OM::XML::MapperXpathGenerator.generate_relative_xpath(@test_mapper).should == 'oxns:namePart[@type="termsOfAddress"]'
    end
    it "should support default_content_path"
    it "should support mappers without namespaces"
    it "should support mappers without namespaces" do
      @test_mapper.namespace_prefix = nil
      OM::XML::MapperXpathGenerator.generate_relative_xpath(@test_mapper).should == 'namePart[@type="termsOfAddress"]'
    end
  end
  
  describe "generate_absolute_xpath" do
    it "should generate an absolute xpath based on the given mapper" do
      OM::XML::MapperXpathGenerator.generate_absolute_xpath(@test_mapper).should == '//oxns:namePart[@type="termsOfAddress"]'
    end
    it "should support default_content_path"
    it "should support mappers without namespaces" do
      @test_mapper.namespace_prefix = nil
      OM::XML::MapperXpathGenerator.generate_absolute_xpath(@test_mapper).should == '//namePart[@type="termsOfAddress"]'
    end
  end

  describe "generate_constrained_xpath" do
    it "should generate a constrained xpath based on the given mapper" do
      OM::XML::MapperXpathGenerator.generate_constrained_xpath(@test_mapper).should == '//oxns:namePart[@type="termsOfAddress" and contains(":::constraint_value:::")]' 
    end
    it "should support default_content_path"
    it "should support mappers without namespaces"
  end
  
end