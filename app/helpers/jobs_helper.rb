module JobsHelper
  def render_job_status(job)
     if job.is_hidden
    content_tag(:span,"(隱藏)", :class => "fa fa-lock")
     else
    content_tag(:span,"(公開)", :class => "fa fa-globe")
     end
   end
end
