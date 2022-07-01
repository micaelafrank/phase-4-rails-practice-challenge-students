class StudentsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :invalid_record
rescue_from ActiveRecord::RecordNotFound, with: :no_record_found


    def index
        students = Student.all
        render json: students 
    end

    def show
        student = find_student
        render json: student 
    end

    def create
        student = Student.create!(student_params)
        render json: student, status: :created
    end

    def update
        student = find_student
        student.update!(student_params)
        render json: student
    end

    def destroy
        student = find_student
        student.destroy
        head :no_content
    end

    private

    def find_student
        Student.find(params[:id])
    end

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end

    def invalid_record(invalid)
        render json: {errors: invalid.record.error.messages}, status: :unprocessable_entity
    end

    def no_record_found
        render json: { errors: "No record exists for this student, try again." }, status: :not_found
    end

end
