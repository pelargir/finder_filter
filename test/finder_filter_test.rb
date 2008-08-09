require File.expand_path(File.dirname(__FILE__) + '/test_helper')

class TestController < ActionController::Base; end

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
end
