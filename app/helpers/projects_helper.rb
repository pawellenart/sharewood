module ProjectsHelper
  def user_in_project?(user)
    if @project && !@project.title.nil?
      @project.users.include?(user)
    else
      false
    end
  end
end
