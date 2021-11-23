module PostFinder
  extend self

  def run(id)
    post = Post.find_by id: id
    post.decorate
  end
end
