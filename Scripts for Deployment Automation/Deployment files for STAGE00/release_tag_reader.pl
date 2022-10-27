#!/usr/bin/perl

use JSON::PP;
use Term::ANSIColor;
use YAML::Tiny;

####################### User Defined start #######################
my $base_path = "/home/common00/vidyasagar/cloud_common00";

my $api_yaml = "$base_path/apiservice.yaml";
my $apiaqp_yaml = "$base_path/apiserviceaqp.yaml";
my $ig_yaml = "$base_path/imggenerator.yaml";
my $inbound_yaml = "$base_path/inbound.yaml";
my $outbound_yaml = "$base_path/outbound.yaml";
my $scheduler_yaml = "$base_path/scheduler.yaml";
my $dash_yaml = "$base_path/dashboard.yaml";
my $lbs_yaml = "$base_path/lbs.yaml";
my $ld_yaml = "$base_path/ld.yaml";
my $ikea_yaml = "$base_path/ikea_converter.yaml";
my $realtime_yaml = "$base_path/realtime_nike.yaml";
my $square_yaml = "$base_path/square_pos.yaml";
my $pickcel_yaml = "$base_path/pickcel.yaml";


my $API='template_mgmt_api_img';
my $APIAQP='api_aqp_img';
my $IG='common_ig_jdk16_img';
my $INBOUND='multitenant_inbound_img';
my $OUTBOUND='multitenant_outbound_img';
my $SCHEDULER='common_scheduler_img';
my $DASH='template_levels_dashboard_img';
my $LBS='multitenant_lbs_img';
my $LD='common_ld_img';
my $IKEA='common_ikea_converter_img';
my $REALTIME='common_realtime_nike_img';
my $SQUARE='common_square_pos_img';
my $PICKCEL='slm_lcd_pickcel_frontend_img';

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
                        read_latest_acr($IG, $ig_yaml);
                        read_latest_acr($INBOUND, $inbound_yaml);
                        read_latest_acr($OUTBOUND, $outbound_yaml);
                        read_latest_acr($SCHEDULER, $scheduler_yaml);
                        #read_latest_acr($DBOPERATOR, $dboperator_yaml);
                        read_latest_acr($LD, $ld_yaml);
                        read_latest_acr($DASH, $dash_yaml);
                        read_latest_acr($API, $api_yaml);
                        read_latest_acr($APIAQP, $apiaqp_yaml);
                        read_latest_acr($LBS, $lbs_yaml);
                        #read_latest_acr($IKEA, $ikea_yaml);
                        read_latest_acr($REALTIME, $realtime_yaml);
                        read_latest_acr($SQUARE, $square_yaml);
                        read_latest_acr($PICKCEL, $pickcel_yaml);
}

sub read_latest_acr()
{
        my ($acr_img, $yaml_file) = @_;


        my $acr_cmd_output = `az acr repository  show-manifests -n solumACRms --repository $acr_img --orderby time_desc 2>/dev/null`;
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
                        # Dashboard tag info is also read by api service, So Dashboard version must be changed in api service yaml file.
                        # Api service must be restarted
                        if ( $acr_img eq $DASH )
                        {
                            # Sleeping for 2 secs, To get a unique timestamp than peviously deployed Dashboard time.
                            sleep(2);

                            my $api_yaml_file_parser_dash = YAML::Tiny->read($api_yaml);

                            # Positon of below elements are fixed in yaml file.
                            # Any changes to position of 'env' elements in yaml, below indices (2,3) must be adjusted accordingly

                            my $existing_dash_release_date = $api_yaml_file_parser_dash->[0]{spec}->{template}->{spec}->{containers}->[0]{env}->[2]->{value};
                            my $existing_dash_tag = $api_yaml_file_parser_dash->[0]{spec}->{template}->{spec}->{containers}->[0]{env}->[3]->{value};

                            my $dash_currTime = `date +"%Y-%m-%d %H:%M:%S"`;

                            # Removing new line if any
                            chomp $dash_currTime;

                            if ($existing_dash_release_date ne '')
                            {
                                system("perl -pi -e 's/$existing_dash_release_date/$dash_currTime/g;' $api_yaml >/dev/null 2>/dev/null");
                            }


                            if ($existing_dash_tag ne '')
                            {
                                system("perl -pi -e 's/$existing_dash_tag/$latest_tag/g;' $api_yaml >/dev/null 2>/dev/null");
                            }


                        }
                        # LD tag info is also read by api service, So LD version must be changed in api service yaml file.
                        # Api service must be restarted
                        elsif ( $acr_img eq $LD )
                        {

                            # Sleeping for 2 secs, To get a unique timestamp than peviously deployed Dashboard time.
                            sleep(2);

                            my $api_yaml_file_parser_ld = YAML::Tiny->read($api_yaml);

                            # Positon of below elements are fixed in yaml file.
                            # Any changes to position of 'env' elements in yaml, below indices (2,3) must be adjusted accordingly

                            my $existing_ld_release_date = $api_yaml_file_parser_ld->[0]{spec}->{template}->{spec}->{containers}->[0]{env}->[4]->{value};
                            my $existing_ld_tag = $api_yaml_file_parser_ld->[0]{spec}->{template}->{spec}->{containers}->[0]{env}->[5]->{value};

                            my $ld_currTime = `date +"%Y-%m-%d %H:%M:%S"`;

                            # Removing new line if any
                            chomp $ld_currTime;

                            if ($existing_ld_release_date ne '')
                            {
                                system("perl -pi -e 's/$existing_ld_release_date/$ld_currTime/g;' $api_yaml >/dev/null 2>/dev/null");                            }


                            if ($existing_ld_tag ne '')
                            {
                                system("perl -pi -e 's/$existing_ld_tag/$latest_tag/g;' $api_yaml >/dev/null 2>/dev/null");
                            }


                        }
                        # Pickcel tag info is also read by api service, So Pickcel version must be changed in api service yaml file.
                        # Api service must be restarted
                        elsif ( $acr_img eq $PICKCEL )
                        {

                            # Sleeping for 2 secs, To get a unique timestamp than peviously deployed Dashboard time.
                            sleep(2);

                            my $api_yaml_file_parser_pickcel = YAML::Tiny->read($api_yaml);

                            # Positon of below elements are fixed in yaml file.
                            # Any changes to position of 'env' elements in yaml, below indices (6,7) must be adjusted accordingly

                            my $existing_pickcel_release_date = $api_yaml_file_parser_pickcel->[0]{spec}->{template}->{spec}->{containers}->[0]{env}->[6]->{value};
                            my $existing_pickcel_tag = $api_yaml_file_parser_pickcel->[0]{spec}->{template}->{spec}->{containers}->[0]{env}->[7]->{value};

                            my $pickcel_currTime = `date +"%Y-%m-%d %H:%M:%S"`;

                            # Removing new line if any
                            chomp $pickcel_currTime;

                            if ($existing_pickcel_release_date ne '')
                            {
                                system("perl -pi -e 's/$existing_pickcel_release_date/$pickcel_currTime/g;' $api_yaml >/dev/null 2>/dev/null");                            }


                            if ($existing_pickcel_tag ne '')
                            {
                                system("perl -pi -e 's/$existing_pickcel_tag/$latest_tag/g;' $api_yaml >/dev/null 2>/dev/null");
                            }
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
