require File.expand_path(File.dirname(__FILE__) + '/test_helper')

class TestController < ActionController::Base; end
class TestsController < ActionController::Base; end

describe FinderFilter do
  it "should assign before filter and define method when model specified" do
    controller = TestController
    controller.extend FinderFilter
    controller.expects(:before_filter).with("find_foo", {})
    controller.expects(:define_method).with("find_foo")
    controller.finder_filter :foo
  end
  
  it "should assign before filter and define method when model not specified" do
    controller = TestController
    controller.extend FinderFilter
    controller.expects(:before_filter).with("find_test", {})
    controller.expects(:define_method).with("find_test")
    controller.finder_filter
  end
  
  it "should assign before filter and define method when model not specified and controller name is plural" do
    controller = TestsController
    controller.extend FinderFilter
    controller.expects(:before_filter).with("find_test", {})
    controller.expects(:define_method).with("find_test")
    controller.finder_filter
  end
  
  it "should assign before filter and define method when options are specified" do
    controller = TestController
    controller.extend FinderFilter
    controller.expects(:before_filter).with("find_test", {})
    controller.expects(:define_method).with("find_test")
    controller.finder_filter :by => :permalink, :param => :name
  end
  
  it "should assign before filter with options" do
    controller = TestController
    controller.extend FinderFilter
    controller.expects(:before_filter).with("find_test", :only => [:show, :edit])
    controller.finder_filter :only => [:show, :edit]
  end
end
