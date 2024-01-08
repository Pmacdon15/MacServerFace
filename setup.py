import os
import re

def get_script_directory():
    # Get the current directory where the Python script is located
    return os.path.dirname(os.path.realpath(__file__))

def list_files_by_extension(folder, file_extension):
    # List all files with the specified file extension in the folder
    return [filename for filename in os.listdir(folder) if filename.endswith(file_extension)]

def update_files_in_folder(folder, file_extension, new_ip_address, port='3002'):
    # List all files with the specified file extension in the folder
    files = list_files_by_extension(folder, file_extension)
    
    for filename in files:
        # Read the content of the script file
        script_file_path = os.path.join(folder, filename)
        with open(script_file_path, 'r') as file:
            script_content = file.read()
        
        # Use a regular expression to find and replace the IP address
        pattern = rf'http://(.*?):{port}'
        new_script_content = re.sub(pattern, f'http://{new_ip_address}:{port}', script_content)

        # Write the updated content back to the script file
        with open(script_file_path, 'w') as file:
            file.write(new_script_content)

        print(f"Updated the address part in {filename} to: {new_ip_address}:{port}")

if __name__ == "__main__":
    script_directory = get_script_directory()
    new_ip_address = input('Enter the new IP address (e.g., 97.52.135.134): ')

    #  Update .js files with a specific pattern
    scripts_folder = os.path.join(script_directory, 'HIDScripts(ALOA)')
    update_files_in_folder(scripts_folder, '.js', new_ip_address)

    # Update .txt files with the same pattern as .ps1 files
    ducky_scripts_folder = os.path.join(script_directory, 'duckyScripts')
    update_files_in_folder(ducky_scripts_folder, '.txt', new_ip_address)

    # Update .ps1 files in the 'scripts' folder
    scripts_folder = os.path.join(script_directory, 'scripts')
    update_files_in_folder(scripts_folder, '.ps1', new_ip_address)

    # Update .ps1 files in the 'manualLaunch' folder
    manual_launch_folder = os.path.join(script_directory, 'powerShell')
    update_files_in_folder(manual_launch_folder, '.ps1', new_ip_address)

    # Update .sh files in the 'scripts' folder
    scripts_folder = os.path.join(script_directory, 'scripts')
    update_files_in_folder(scripts_folder, '.sh', new_ip_address)

    
