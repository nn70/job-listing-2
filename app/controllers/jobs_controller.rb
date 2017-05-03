class JobsController < ApplicationController
before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy, :collect, :discollect]
before_action :validate_search_key, only: [:search]

  def show
    @job = Job.find(params[:id])

    if @job.is_hidden
      flash[:warning] = "This job already archieved"
      redirect_to root_path
    end
  end

  def edit
    @job = Job.find(params[:id])
  end

  def index
    # 随机推荐五个职位 #
    @suggests = Job.published.random5
    @jobs = case params[:order]
            when 'by_lower_bound'
              Job.published.order('wage_lower_bound DESC').paginate(:page => params[:page], :per_page => 10)
            when 'by_upper_bound'
              Job.published.order('wage_upper_bound DESC').paginate(:page => params[:page], :per_page => 10)
            when 'by_city'
              Job.published.order('city DESC').paginate(:page => params[:page], :per_page => 10)
            else
              Job.published.recent.paginate(:page => params[:page], :per_page => 10)
            end

  end


  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to jobs_path
    else
      render :new
    end
  end

  def update
    @job = Job.find(params[:id])
    if @job.update(job_params)
      redirect_to jobs_path
    else
      render:edit
    end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy
      redirect_to jobs_path
  end

  def search
    if @query_string.present?
      search_result = Job.published.ransack(@search_criteria).result(:distinct => true)
      @jobs = search_result.recent.paginate(:page => params[:page], :per_page => 5 )
    end
  end

  def about
  end

  def collect
    @job = Job.find(params[:id])
    if !current_user.favorite?(@job)
      current_user.collect!(@job)
      flash[:notice] = "Collect Job Success!"
    else
      flash[:warning] = "Have Collected"
    end
    redirect_to :back
  end

  def discollect
    @job = Job.find(params[:id])
    if current_user.favorite?(@job)
      current_user.discollect!(@job)
      flash[:alert] = "Collection is canceled"
    else
      flash[:alert] = "NO collection"
    end
    redirect_to :back
  end

private

    def job_params
      params.require(:job).permit(:title, :description, :wage_upper_bound, :wage_lower_bound, :contact_email, :is_hidden, :category, :company, :city)
    end

protected
  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "")
    if params[:q].present?
      @search_criteria =  {
        title_or_company_or_city_cont: @query_string
      }
    end
  end

  def search_criteria(query_string)
    { :title_cont => query_string }
  end
end
