class UploadFilesController < ApplicationController
  before_action :set_upload_file, only: [:show, :edit, :update, :destroy]

  # GET /upload_files
  # GET /upload_files.json
  def index
    @upload_files = UploadFile.all
  end

  # GET /upload_files/1
  # GET /upload_files/1.json
  def show
  end

  # GET /upload_files/new
  def new
    @upload_file = UploadFile.new
  end

  # GET /upload_files/1/edit
  def edit
  end

  # POST /upload_files
  # POST /upload_files.json
  def create
    # アップロードされたファイルのパラメータの中にupload_fileというパラメータを作ってしまった。
    # _form.html.erbの中でf.file_field :upload_fileとやっているのがそれ。
    upload_file = upload_file_params[:upload_file][:upload_file]
    content = {}
    puts upload_file
    puts "hoge #{upload_file.original_filename}"
    
    if upload_file != nil
      content[:file] = upload_file.read
      content[:filename] = upload_file.original_filename
    end

    @upload_file = UploadFile.new(content)
    puts @upload_file
    respond_to do |format|
      if @upload_file.save
        format.html { redirect_to @upload_file, notice: 'Upload file was successfully created.' }
        format.json { render :show, status: :created, location: @upload_file }
      else
        format.html { render :new }
        format.json { render json: @upload_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /upload_files/1
  # PATCH/PUT /upload_files/1.json
  def update
    respond_to do |format|
      if @upload_file.update(upload_file_params)
        format.html { redirect_to @upload_file, notice: 'Upload file was successfully updated.' }
        format.json { render :show, status: :ok, location: @upload_file }
      else
        format.html { render :edit }
        format.json { render json: @upload_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /upload_files/1
  # DELETE /upload_files/1.json
  def destroy
    @upload_file.destroy
    respond_to do |format|
      format.html { redirect_to upload_files_url, notice: 'Upload file was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_upload_file
      @upload_file = UploadFile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def upload_file_params
      puts params
      params
    end
end
