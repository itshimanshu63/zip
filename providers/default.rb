def whyrun_supported?
  true
end

def load_current_resource
  @current_resource = new_resource.class.new(new_resource.name)
  @zip = OO::Zip.new
end

action :compress do
  if @zip.exist?(new_resource.folder_path)
    @zip.inputDir = new_resource.folder_path
    @zip.outputFile = new_resource.output_zip_file
    @zip.write()
    Chef::Log.info "Folder Zipped to #{new_resource.output_zip_file}"
    new_resource.updated_by_last_action(true)
  else
    Chef::Log.info "Input File #{new_resource.folder_path} for zipping not found"
  end
end
