resource "aws_guardduty_detector" "detector" {
  enable = true

  datasources {
    s3_logs {
      enable = false
    }
    kubernetes {
      audit_logs {
        enable = true
      }
    }
    malware_protection {
      scan_ec2_instance_with_findings {
        ebs_volumes {
          enable = true
        }
      }
    }
  }
}