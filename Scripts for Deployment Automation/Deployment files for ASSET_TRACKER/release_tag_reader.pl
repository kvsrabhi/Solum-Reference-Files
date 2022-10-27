#!/usr/bin/perl

use JSON::PP;
use Term::ANSIColor;
use YAML::Tiny;

####################### User Defined start #######################
my $base_path = "/home/assettracker/cloud_assettracker";
my $base_version_string = "1.0";

my $dsbackend_yaml = "$base_path/data-server-backend.yaml";
my $dsfrontend_yaml = "$base_path/data-server-frontend.yaml";
my $wsinbound_yaml = "$base_path/asset-websocket-inbound.yaml";
my $restapiinbound_yaml = "$base_path/asset-restapi-inbound.yaml";
my $dboutbound_yaml = "$base_path/asset-db-outbound.yaml";
my $azureinfo_yaml = "$base_path/asset-azure-info.yaml";



my $DSBEND='release_assettracker_data_server_backend_img';
my $DSFEND='release_assettracker_data_server_frontend_img';
my $RESTAPIINBOUND='release_assettracker_restapi_inbound_img';
my $WSINBOUND='release_assettracker_websocket_inbound_img';
my $DBOUTBOUND='release_assettracker_db_outbound_img';
my $AZUREINFO='release_assettracker_azure-info_img';

####################### User Defined end #######################

my $check = 0;
my $base_version_search_str = "value: \"1.0.";

print  "\n*****************Please Wait****************** \n";
sub main()
{
        get_user_input();

}

sub get_user_input()
{
                        read_latest_acr($DSBEND, $dsbackend_yaml);
                        read_latest_acr($DSFEND, $dsfrontend_yaml);
                        read_latest_acr($RESTAPIINBOUND, $restapiinbound_yaml);
                        read_latest_acr($WSINBOUND, $wsinbound_yaml);
                        read_latest_acr($DBOUTBOUND, $dboutbound_yaml);
                        read_latest_acr($AZUREINFO, $azureinfo_yaml);
}

sub read_latest_acr()
{
        my ($acr_img, $yaml_file) = @_;


        my $acr_cmd_output = `az acr repository  show-manifests -n slmassettrackeracr00 --repository $acr_img --orderby time_desc 2>/dev/null`;
        #capruting above command's execution result
        my $acr_result = `echo $?`;

        if ( $acr_result != 0 )
        {
                print color(red), "\nProblem with ACR login. Please check if login details has been changed. Try with below command!! \n" , color("reset");
                print color(red), "\nEx: az login -u admin\@solumpro1.onmicrosoft.com -p xxxxxxx \n" , color("reset");
                exit -1;
        }

        #print "$acr_cmd_output \n";


        eval {
                $pl_json_scalar = decode_json( $acr_cmd_output );
                1;
        } or do {
                my $exception_decode = $@;
                print color(red), "Decode: Oops Seems ACR OUTPUT JSON Data is Wrong :)\n", color("reset");
                print color(green), "\n $exception_decode", color("reset");
                exit;
        };


        my $latest_tag = $pl_json_scalar->[0]->{tags}[0];
        my $existing_tag = check_yaml($yaml_file);


        # Printing all latest ACR Tag's Version and comparing with existing yaml's tag

        if ( $latest_tag != $existing_tag )
        {
                $check = 1;

                print "$acr_img:     ", color(red), "$existing_tag    ->    $latest_tag \n", color("reset");

                my $result = system("perl -pi.back -e 's/$existing_tag/$latest_tag/g;' $yaml_file >/dev/null 2>/dev/null");

                # Capturing above command's execution result
                if ( $result == 0)
                {
                        # Data Server Frontend tag info is also read by Data Server Backend, So Data Server Frontend version must be changed in Data Server Backend yaml file.
                        # Data Server Backend must be restarted
                        if ( $acr_img eq $DSFEND )
                        {
                            # Sleeping for 2 secs, To get a unique timestamp than peviously deployed Data Server Frontend time.
                            sleep(2);

                            my $dsbackend_yaml_file_parser_dsfend = YAML::Tiny->read($dsbackend_yaml);

                            # Positon of below elements are fixed in yaml file.
                            # Any changes to position of 'env' elements in yaml, below indices (2,3) must be adjusted accordingly

                            my $existing_dsfend_release_date = $dsbackend_yaml_file_parser_dsfend->[0]{spec}->{template}->{spec}->{containers}->[0]{env}->[2]->{value};
                            my $existing_dsfend_tag = $dsbackend_yaml_file_parser_dsfend->[0]{spec}->{template}->{spec}->{containers}->[0]{env}->[3]->{value};

                            my $dsfend_currTime = `date +"%Y-%m-%d %H:%M:%S"`;

                            # Removing new line if any
                            chomp $dsfend_currTime;

                            if ($existing_dsfend_release_date ne '')
                            {
                                system("perl -pi -e 's/$existing_dsfend_release_date/$dsfend_currTime/g;' $dsbackend_yaml >/dev/null 2>/dev/null");
                            }


                            if ($existing_dsfend_tag ne '')
                            {
                                system("perl -pi -e 's/$existing_dsfend_tag/$latest_tag/g;' $dsbackend_yaml >/dev/null 2>/dev/null");                            }

                        }
                        else
                        {
                            my $yaml_file_parser = YAML::Tiny->read($yaml_file);
                            my $existing_release_date = $yaml_file_parser->[0]{spec}->{template}->{spec}->{containers}->[0]{env}->[0]->{value};

                            my $currTime = `date +"%Y-%m-%d %H:%M:%S"`;

                            # Removing new line if any
                            chomp $currTime;
                            
                            if ($existing_release_date ne '')
                            {
                                system("perl -pi -e 's/$existing_release_date/$currTime/g;' $yaml_file >/dev/null 2>/dev/null");
                            }

                        }


                        print color(green), "\nSuccessfully updated '$yaml_file' with updated acr tag: $latest_tag !! \n", color("reset");

                }
        }
}

sub check_yaml()
{ 
    my ($file) = @_;

    my $used_tag = 0;

    open(FH, $file) or die("File $file not found"); 
      
    while(my $String = <FH>) 
    { 
        if($String =~ /- image:/) 
        { 
            #print "$String \n";

            my @acr_line = split(':', $String); 
            #print "$acr_line[2]"; 
            
            my @tag = split(' ', $acr_line[2]);
            $used_tag = $tag[0];

            #removing new line if any
            chomp $used_tag;

            # print "$used_tag \n"; 
        } 
    } 
    close(FH); 

    return $used_tag;
}


sub read_base_version_from_yaml()
{ 
    my ($file) = @_;

    my $used_tag = 0;
    my $base_version = "";

    open(FH, $file) or die("File $file not found"); 
      
    while(my $String = <FH>) 
    { 
        if (index($String, $base_version_search_str) != -1)
        { 
            my @base_version_line = split(':', $String); 
            print "$base_version_line[1]"; 
            
            $base_version = $base_version_line[1];

            #removing new line if any
            chomp $base_version;

            #removing last " from base_version_string
            chop($base_version);
            
            #removing first " from base_version_string
            $base_version = substr($base_version, 2);
        } 
    } 
    close(FH); 

    return $base_version;
}

main();

print  "\n*****************Finished****************** \n";