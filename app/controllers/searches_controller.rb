class SearchesController < ApplicationController
  def search

    if params[:tag] != nil
      @result = Book.where("tag = :tag", {tag:params[:tag]})
      @mode = "book"
      @text = params[:tag]
      return
    end
    @mode = params[:mode]
    @text = params[:text]
    case params[:match]
    when "kanzen" then
      matchRule = params[:text]
    when "zenpou" then
      matchRule = "%#{params[:text]}"
    when "kouhou" then
      matchRule = "#{params[:text]}%"
    when "bubun" then
      matchRule = "%#{params[:text]}%"
    else
      matchRule = params[:text]
    end

    if @mode == "book"
      @result = Book.where("title LIKE :matchRule", {matchRule:matchRule})
    else
      @result = User.where("name LIKE :matchRule", {matchRule:matchRule})
    end
  end
end
