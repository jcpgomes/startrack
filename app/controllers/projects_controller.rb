class ProjectsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @projects = Project.all
    load_page_title "Listing all projects"
  end

  def show
    @project = Project.find(params[:id])
    load_page_title @project.name
    @tasks = @project.tasks.all
    @task_todo = @project.tasks.todo
    @task_scheduled = @project.tasks.scheduled
    @task_current = @project.tasks.current
    @task_done = @project.tasks.done
  end

  def new
    @project = Project.new
    load_page_title "New project"
  end

  def edit
    @project = Project.find(params[:id])
    load_page_title "Editing project #{@project.name}"
  end

  def create
    @project = Project.new(params[:project])
    if @project.save
      redirect_to @project, notice: 'Project was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_url
  end
end
