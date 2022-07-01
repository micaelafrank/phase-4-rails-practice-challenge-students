class InstructorsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :invalid_record
rescue_from ActiveRecord::RecordNotFound, with: :no_record_found

    def index
        instructors = Instructor.all
        render json: instructors 
    end

    def show
        instructor = find_instructor
        render json: instructor  
    end

    def create
        instructor = Instructor.create!(instructor_params)
        render json: instructor 
    end

    def update
        instructor = find_instructor
        instructor.update!(instructor_params)
        render json: instructor
    end

    def destroy
        instructor = find_instructor
        instructor.destroy
        head :no_content
    end

    private

    def find_instructor
        Instructor.find(params[:id])
    end

    def instructor_params
        params.permit(:name)
    end

    def invalid_record(invalid)
        render json: {errors: invalid.record.errors.messages}, status: :unprocessable_entity
    end

    def no_record_found
        render json: { errors: "No record exists for this student, try again." }, status: :not_found
    end

end
