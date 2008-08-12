require File.expand_path(File.dirname(__FILE__) + '/test_helper')

class TestController < ActionController::Base; extend FinderFilter; end
class TestsController < ActionController::Base; extend FinderFilter; end

describe FinderFilter do
  before { @controller = TestController }
  
  it "should assign before filter when model specified" do
    @controller.expects(:before_filter).with(:"find_foo", {})
    @controller.finder_filter :foo
  end

  it "should assign before filter when model not specified" do
    @controller.expects(:before_filter).with(:"find_test", {})
    @controller.finder_filter
  end

  it "should assign before filter when model not specified and controller name is plural" do
    controller = TestsController
    controller.expects(:before_filter).with(:"find_test", {})
    controller.finder_filter
  end

  it "should assign before filter when options are specified" do
    @controller.expects(:before_filter).with(:"find_test", {})
    @controller.finder_filter :by => :permalink, :param => :name
  end

  it "should assign before filter with options" do
    @controller.expects(:before_filter).with(:"find_test", :only => [:show, :edit])
    @controller.finder_filter :only => [:show, :edit]
  end
  
  it "should assign prepend before filter when prepend option specified" do
    @controller.expects(:prepend_before_filter).with(:"find_test", {})
    @controller.finder_filter :prepend => true
  end
  
  it "should assign prepend before filter when prepend option specified with other options" do
    @controller.expects(:prepend_before_filter).with(:"find_test", :only => [:show, :edit])
    @controller.finder_filter :only => [:show, :edit], :prepend => true
  end
  
  it "should define method when model specified" do
    @controller.expects(:define_method).with("find_foo")
    @controller.finder_filter :foo
  end

  it "should define method when model not specified" do
    @controller.expects(:define_method).with("find_test")
    @controller.finder_filter
  end

  it "should define method when model not specified and controller name is plural" do
    controller = TestsController
    controller.expects(:define_method).with("find_test")
    controller.finder_filter
  end

  it "should define method when options are specified" do
    @controller.expects(:define_method).with("find_test")
    @controller.finder_filter :by => :permalink, :param => :name
  end
end
