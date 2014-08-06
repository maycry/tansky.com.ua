class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate, only: [:edit, :update, :new, :create]

  # GET /posts
  # GET /posts.json
  def index
    if params[:tag]
        @posts = Post.tagged_with(params[:tag])
      else
        @posts = Post.all
      end
  end

  def drafts
    @posts = Post.all
  end

  def toggle_active  
    @post = Post.find(params[:id])  
    @post.toggle!(:active)  
    render nothing: true  
  end  

  # GET /posts/1
  # GET /posts/1.json
  def show
  end
  
  def new
    @post = Post.new
  end

  
  # GET /posts/1/edit
  def edit
    @tags = Post.tag_counts_on(:tags)
  end
  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if params[:post][:image_attributes]
        @post.save
        @name = params[:post][:image_attributes][:image][0].original_filename
        s3 = AWS::S3.new
        bucket = s3.buckets["tansky.com.ua"]
        obj = bucket.objects["blog/#{@post.id}/#{@name}"]
        obj.write(params[:post][:image_attributes][:image][0].read, :acl => :public_read)
      else
        if @post.save
          format.html { redirect_to posts_url }
          format.json { render action: 'show', status: :created, location: @post }
        else
          format.html { render action: 'new' }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  end




  def update
    respond_to do |format|
      if params[:post][:image_attributes]
        @name = params[:post][:image_attributes][:image][0].original_filename
        s3 = AWS::S3.new
        bucket = s3.buckets["tansky.com.ua"]
        obj = bucket.objects["blog/#{@post.id}/#{@name}"]
        obj.write(params[:post][:image_attributes][:image][0].read, :acl => :public_read)
        format.js
      else
        if @post.update(post_params)
          format.html { redirect_to @post, notice: 'post was successfully updated.' }
        end
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  #def update
  #  respond_to do |format|
  #    if @post.update(post_params)
  #      format.html { redirect_to @post, notice: 'post was successfully updated.' }
  #      format.json { head :no_content }
  #    else
  #      format.html { render action: 'edit' }
  #      format.json { render json: @post.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :tag_list)
    end

    def authenticate(return_point = request.url)
      unless session[:log_in]
        flash[:error] = "You must be logged in to access this section"
        set_return_point(return_point)
        redirect_to login_path
      end
    end

    def set_return_point(path, overwrite = false)
      if overwrite or session[:return_point].blank?
        session[:return_point] = path
      end
    end
end
