remote_file "/usr/local/bin/jq" do
    if node['kernel']['machine'] == "x86_64"
	source "http://stedolan.github.io/jq/download/linux64/jq"
        mode "0755"
    else
        source "http://stedolan.github.io/jq/download/linux32/jq"
        mode "0755"
    end
end
