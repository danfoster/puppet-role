Facter.add(:profile) do
  setcode do
    if File.file?("/etc/puppetprofile")
      # read the first line of the file and ignore the rest
      file = File.new("/etc/puppetprofile", "r")
      line = file.gets
      file.close

      line
    end
  end
end
