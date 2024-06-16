class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def get_favorites_count
    favorites = Favorite.where(book_id: id)
    if favorites == nil
      0
    else
      favorites.count
    end
  end

  def get_comments_count
    comments = BookComment.where(book_id: id)
    if comments == nil
      0
    else
      comments.count
    end
  end
end
