require File.expand_path(File.dirname(__FILE__) + '/test_helper')

class BooksController < ActionController::Base; extend FinderFilter; def show; end; end
class Book < ActiveRecord::Base; end
class Novel < ActiveRecord::Base; end
class Tome < ActiveRecord::Base; def param_column; "foo"; end; end

describe FinderFilter do
  before do
     @controller = BooksController.new
  end
  
  it "should call find on the model" do
     BooksController.finder_filter
     @controller.params = {:id => 7}
     Book.expects(:find).with(7)
     @controller.find_book
  end

  it "should call find on a column when specified" do
     BooksController.finder_filter :by => :name
     @controller.params = {:id => "foo"}
     Book.expects(:find_by_name).with("foo")
     @controller.find_book
  end

  it "should call find on a different model when specified" do
     BooksController.finder_filter :novel
     @controller.params = {:id => 7}
     Novel.expects(:find).with(7)
     @controller.find_novel
  end

  it "should call from_param when param_column is defined" do
    BooksController.finder_filter :tome
    @controller.params = {:id => 7}
    Tome.expects(:from_param).with(7)
    @controller.find_tome
  end

end
