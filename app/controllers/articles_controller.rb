class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    # @articles = Article.includes(:comments).all
    # @articles = Article.joins(:comments).group('id').count # só dá os totais

    # ignora artigos sem comments, inner join
    # @articles = Article.joins(:comments).select("articles.id, articles.name, articles.content, 
    # articles.published, count(comments.article_id) as num_comments").group(:id)

    # left join
    @articles = Rails.cache.fetch('articles_index') do
    Article.left_joins(:comments).select("articles.id, articles.name, articles.content, 
      articles.published, count(comments.article_id) as num_comments").group(:id)
    end
  end

  def apitest

    #render json: Article.includes(:comments).to_json(include: :comments)

    json = Rails.cache.fetch('articles') do
       Article.includes(:comments).to_json(include: :comments)
    end

    render json: json
  end 

  def apitest2
    render_cached_json("api:foos", expires_in: 1.hour) do
      Article.includes(:comments).to_json(include: :comments)
    end
  end

  def render_cached_json(cache_key, opts = {}, &block)
    opts[:expires_in] ||= 1.day

    expires_in opts[:expires_in], :public => true
    data = Rails.cache.fetch(cache_key, {raw: true}.merge(opts)) do
      block.call.to_json
    end

    render :json => data
  end



  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    authorize @article

    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:name, :content, :published)
    end
end
