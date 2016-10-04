class CoursesController < ApplicationController

  def index
    @courses = Course.all


    # @course = Course.find(params[:id])
  end

  def new 
    @course = Course.new    # #new and #build can be used interchangeably 
    # @user = current_user.id #User.find(params[:id])
    # @course = current_user.courses.build(course_params)
  end

  def create
    # byebug #golden location to check the information that gets passed when the action create is invoked

    # @course = Course.new(course_params) #this doesnt invoke association between course and user
    @course = current_user.courses.new(course_params) #same with what build does
    # @course = current_user.courses.build(course_params) #<-- #using this will attach the user id
    

    @course.begin_date = DateTime.strptime(params[:daterange].split[0], "%m/%d/%Y")
    @course.end_date = DateTime.strptime(params[:daterange].split[-1], "%m/%d/%Y")
    # byebug #to know the information that has been processed when specific method is defined 
              #without defining this method, it will be nil for both: begin_date and end_date

    #when params(data) reaches this stage, it will be manipulated readily in a usable form
    if @course.save
      redirect_to @course
    else
      redirect_to new_course_path #which will also render "courses/new"
    end
  end

  def show 
    @course = Course.find(params[:id]) #you can now do Course.find because @course has been created from the #create
    
    @total_weeks = Course.duration(@course.end_date, @course.begin_date) 
         # actually, ^ the part where we call the method defined in course.rb
      #remember: always define the information that you want to get printed in the destination page
  end

  #it's a mistake not to define this. Rails doesnt know where to get the 'id'. It says that argument is blank
  # edit and update do 2 different things
  def edit 
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])

    if @course.update(course_params) 
      redirect_to @course 
    else
      render "edit"
    #   redirect_to edit_course_path(@course)  #how about this?
    end
  end

  def destroy 
    @course = Course.find(params[:id])
    @course.destroy

    redirect_to courses_path
  end


  private

  def course_params
    params.require(:course).permit(:title, :description, :university, :begin_date, :end_date)
  end
end


