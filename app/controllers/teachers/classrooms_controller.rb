class Teachers::ClassroomsController < ApplicationController
  respond_to :json, :html
  before_filter :teacher!
  before_filter :authorize!

  def index
    if current_user.classrooms.empty?
      redirect_to new_teachers_classroom_path
    else
      @classrooms = current_user.classrooms
      @classroom = @classrooms.first
    end
  end

  def new
    @classroom = current_user.classrooms.new
    @classroom.generate_code
  end

  def regenerate_code
    cl = Classroom.new
    cl.generate_code
    render json: { code: cl.code }
  end

  def create
    @classroom = Classroom.create(classroom_params.merge(teacher: current_user))
    if @classroom.valid?
      ClassroomCreationWorker.perform_async(@classroom.id)
      if current_user.students.empty?
        redirect_to(controller: 'teachers/classroom_manager', action: 'lesson_planner', tab: 'exploreActivityPacks', grade: @classroom.grade)
      else
        redirect_to teachers_classroom_invite_students_path(@classroom)
      end
    else
      render :new
    end
  end

  def update
    @classroom.update_attributes(classroom_params)
    # this is updated from the students tab of the scorebook, so will make sure we keep user there
    redirect_to teachers_classroom_students_path(@classroom.id)
  end

  def destroy
    @classroom.destroy
    redirect_to teachers_classrooms_path
  end

  def hide
    classroom = Classroom.find(params[:id])
    classroom.visible = false #
    classroom.save(validate: false)
    redirect_to teachers_classrooms_path
  end

  private

  def classroom_params
    params[:classroom].permit(:name, :code, :grade)
  end

  def authorize!
    return unless params[:id].present?
    @classroom = Classroom.find(params[:id])
    auth_failed unless @classroom.teacher == current_user
  end
end
