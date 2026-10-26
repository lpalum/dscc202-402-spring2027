#!/bin/bash

# DSAS 2025 - Post-Create Setup Script
# Verifies Python environment and required packages

set -e  # Exit on any error

echo "🔧 DSAS 2025 - Setting up Python environment"
echo "=============================================="

# Navigate to project root
cd /workspaces/dscc202-402-spring2027

# Verify critical packages are installed
echo "🔍 Verifying Python setup..."
SYSTEM_PYTHON="/usr/local/bin/python3"

if [ -f "$SYSTEM_PYTHON" ]; then
    echo "✅ System Python found: $SYSTEM_PYTHON"

    # Test critical packages
    $SYSTEM_PYTHON -c "import pandas; print(f'✅ pandas {pandas.__version__} available')" || {
        echo "❌ pandas not available"
        exit 1
    }

    $SYSTEM_PYTHON -c "import pyspark; print(f'✅ pyspark {pyspark.__version__} available')" || {
        echo "❌ pyspark not available"
        exit 1
    }

    $SYSTEM_PYTHON -c "import pyarrow; print(f'✅ pyarrow {pyarrow.__version__} available')" || {
        echo "❌ pyarrow not available"
        exit 1
    }

else
    echo "❌ System Python not found"
    exit 1
fi

# Update environment variables in .bashrc for the vscode user
echo "🌐 Updating environment variables..."
cat >> ~/.bashrc << 'EOF'

# DSAS 2025 - Python Configuration
export PYSPARK_PYTHON=/usr/local/bin/python3
export PYSPARK_DRIVER_PYTHON=/usr/local/bin/python3
EOF

echo ""
echo "✅ Python Environment Setup Complete!"
echo "======================================"
echo ""
echo "🎯 Environment Details:"
echo "   • Python: $SYSTEM_PYTHON"
echo "   • PYSPARK_PYTHON: /usr/local/bin/python3"
echo "   • PYSPARK_DRIVER_PYTHON: /usr/local/bin/python3"
echo ""
echo "📚 Ready for Spark with pandas UDF support!"
echo ""