"""add content column to post table

Revision ID: bec26a7e8543
Revises: 267a05a86c13
Create Date: 2024-06-11 15:37:58.292411

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'bec26a7e8543'
down_revision: Union[str, None] = '267a05a86c13'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.add_column('posts', sa.Column('content', sa.String(), nullable=False))
    pass


def downgrade() -> None:
    op.drop_column('posts', 'content')
    pass
