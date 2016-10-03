class Course < ActiveRecord::Base
  #automatically generated when doing rails g user:references as one of the columns
  belongs_to :user

  def self.duration(end_course, begin_course) #so that we can call in the controller: Course.duration(insert-value, insert-value)
    @course_duration = ((end_course - begin_course).to_i)/7 
      #divide by 7 to get number in weeks because by default, it gives value in days
  end

end



   


