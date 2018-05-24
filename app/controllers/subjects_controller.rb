class SubjectsController < ApplicationController
  before_action :set_subject, only: [:show, :edit, :update, :destroy]


  # GET /subjects
  # GET /subjects.json
  def index
    @subjects = Subject.all
  end

  # GET /subjects/1
  # GET /subjects/1.json
  def show
    # find the student object, note since its a subject controller show method, route expects an id (accessed as param[:id]), only difference is while calling this method, student id was passed, instead of subjects id

    # bad design: modifying subject show with student details will interrupt the normal show for subjects
    # @student = Student.find(params[:id])
  end

  # GET /subjects/new
  def new
    # find student id passed from student index html as a params for add subject link
    @student = Student.find(params[:student_id])
    @subject = Subject.new
  end

  # GET /subjects/1/edit
  def edit
  end

  # POST /subjects
  # POST /subjects.json
  def create
    @subject = Subject.new(subject_params)

    ################# debugging params for create method error: Couldn't find Student without an ID ############################
    # student id is passed as a param from student index file
    logger.debug("finding param values from subject form")
      logger.debug(params.inspect)
      logger.debug(params[:subject][:stduent_id].inspect)
    logger.debug("finding param values from subject form")
  ################# debugging hash of hashes in irb ############################
    # hash = {:subject => {:name => "rails" , :subject_id => 2 }}
    # hash[:subject]
    #   => {:name=>"rails", :subject_id=>2}
    # hash[:subject][:subject_id]
    #     => 2
    # hash[:subject[:subject_id]]
    #     TypeError: no implicit conversion of Symbol into Integer
   ################# debugging hash of hashes in irb ############################
   # find student id from subject form passed as a hidden field
    @student = Student.find(params[:subject][:student_id])
    # assign student id to subject
    @subject.student_id = @student.id

    respond_to do |format|
      if @subject.save
        format.html { redirect_to @subject, notice: 'Subject was successfully created.' }
        format.json { render :show, status: :created, location: @subject }
      else
        format.html { render :new }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subjects/1
  # PATCH/PUT /subjects/1.json
  def update
    respond_to do |format|
      if @subject.update(subject_params)
        format.html { redirect_to @subject, notice: 'Subject was successfully updated.' }
        format.json { render :show, status: :ok, location: @subject }
      else
        format.html { render :edit }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subjects/1
  # DELETE /subjects/1.json
  def destroy
    @subject.destroy
    respond_to do |format|
      format.html { redirect_to subjects_url, notice: 'Subject was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subject
      @subject = Subject.find(params[:id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def subject_params
      params.require(:subject).permit(:name, :student_id, :teacher_id)
    end
end
