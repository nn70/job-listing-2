class Admin::JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]
  before_action :require_is_admin
  layout "admin"

    def show
      @job = Job.find(params[:id])

    end

    def edit
      @job = Job.find(params[:id])
      @suggests = Job.published.random5
    end

    def index
      # @jobs = Job.all
      @jobs = Job.recent.paginate(:page => params[:page], :per_page => 10)
      # 随机推荐五个职位 #
      @suggests = Job.published.random5
    end

    def new
      @job = Job.new
      # 随机推荐五个职位 #
      @suggests = Job.published.random5
    end

    def create
      @job = Job.new(job_params)
      if @job.save
        redirect_to admin_jobs_path
      else
        render :new
      end
    end

    def update
      @job = Job.find(params[:id])
      if @job.update(job_params)
        redirect_to admin_jobs_path
      else
        render:edit
      end
    end

    def destroy
      @job = Job.find(params[:id])
      @job.destroy
        redirect_to admin_jobs_path
    end

    def publish
      @job = Job.find(params[:id])
      @job.publish!
      redirect_to :back
    end

    def hide
      @job = Job.find(params[:id])
      @job.hide!
      redirect_to :back
    end

    def search
      if @query_string.present?
        search_result = Job.published.ransack(@search_criteria).result(:distinct => true)
        @jobs = search_result.recent.paginate(:page => params[:page], :per_page => 5 )
      end

      @suggests = Job.published.random5
    end

  private

      def job_params
        params.require(:job).permit(:title, :description, :wage_upper_bound, :wage_lower_bound, :contact_email, :is_hidden, :category, :company, :city)
      end
  end
