    ensure_once.sh LOCKFILE CMD [CMD PARAMETERS]
        - This script ensures that there is at most one instance of CMD by LOCKFILE.
        - By using flock it is always guaranteed that the lock will be released when "CMD" is finished (or gets killed) so no there is no need to manually handle seed or other control mechanisms.
        
        authors : Sergio Perez, Antonio Vega.
        
    
    single_run.sh <lock_file_name> <execution1> [... <executionN>]
        - Based in ensure_once, but lets you set the lock file for multiple execution flow
        
        authors : Sergio Perez
    
    
    single_wait_and_run.sh <lock_file_name> <execution1> [... <executionN>]
        - Like single_run, but it waits 1' instead crashing immediately if the proces is locked
        
        authors : Sergio Perez
        
        
    build-gitflow.sh <repo_path> <branch_type>
        - This scripts reproduces the git-flow on a given repo with a given branch type, applying the naming rules and generating dummy data.
        - The branch types are the default git-flow ones: release-*, hotfix-*, feature-*, bugfix-*, support-*
        
        authors : Sergio Perez
